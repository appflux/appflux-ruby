module AppfluxRuby
  module Sidekiq
    class ErrorHandler
      def call(_worker, context, _queue)
        yield
      rescue Exception => exception
        ::AppfluxRuby::Bugflux.initialize_additional_data
          params = {
            component: 'sidekiq',
            args: context['args'],
            queue: context['queue'],
            message: context['error_message'],
            options: context.except('args', 'queue', 'error_message')
          }

          ::AppfluxRuby::BugfluxNotifier.notify(exception, params)
          raise exception
      end
    end
  end
end
