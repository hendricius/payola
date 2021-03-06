begin
  require 'sidekiq'
rescue LoadError
end

module Payola
  module Worker
    class Sidekiq < BaseWorker
      include ::Sidekiq::Worker if defined? ::Sidekiq::Worker

      def self.can_run?
        defined?(::Sidekiq::Worker)
      end

      def self.call(sale)
        perform_async(sale.guid)
      end
    end
  end
end
