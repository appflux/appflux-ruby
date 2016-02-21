module Delayed
  module Plugins
    class Gnotifier < ::Delayed::Plugin
      callbacks do |lifecycle|
        lifecycle.around(:invoke_job) do |job, *args, &block|
          begin
            block.call(job, *args)
          rescue Exception => exception
            params = job.as_json.merge(
              component: 'delayed_job',
              action: job.payload_object.class.name
            )

            # If DelayedJob is used through ActiveJob, it contains extra info.
            if job.payload_object.respond_to?(:job_data)
              params[:active_job] = job.payload_object.job_data
            end
            ::Gnotifier::BugfluxNotifier.notify(exception, params)
            raise exception
          end
        end
      end
    end
  end
end

Delayed::Worker.plugins << Delayed::Plugins::Gnotifier
