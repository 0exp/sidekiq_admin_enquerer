# frozen_string_literal: true

# @api public
# @since 0.1.0
module SidekiqAdminEnquerer
  require_relative 'sidekiq_admin_enquerer/version'
  require_relative 'sidekiq_admin_enquerer/web_app'

  # @return [Array<String>]
  #
  # @api private
  # @since 0.1.0
  JOB_SKIP_LIST = %w[
    Sidekiq::Extensions::DelayedModel
    Sidekiq::Extensions::DelayedMailer
    Sidekiq::Extensions::DelayedClass
    ApplicationJob
    ActiveJob::QueueAdapters::SidekiqAdapter::JobWrapper
  ].freeze

  class << self
    # @return [Array<Class<ActiveJob::Base>,Class<Sidekiq::Worker>>]
    #
    # @api private
    # @since 0.1.0
    def jobs
      Rails.application.eager_load!

      ObjectSpace.each_object(Class).select do |job_klass|
        next if job_klass.singleton_class?
        next if JOB_SKIP_LIST.any? { job_klass.to_s.include?(_1) }
        job_klass < ActiveJob::Base || job_klass.included_modules.include?(Sidekiq::Worker)
      end
    end

    # @param job_name [String]
    # @return [Class<ActiveJob::Base>,Class<Sidekiq::Worker>]
    #
    # @api private
    # @since 0.1.0
    def find_job(job_name)
      jobs.find { _1.name == job_name || _1.to_s == job_name }
    end

    # @param job [?]
    # @param params [?]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    # rubocop:disable Metrics/AbcSize
    def run_job(job, params)
      # TODO: rework with attribute analysis
      job_perform_method = params['perform_method']
      job_params = params[job_perform_method]
      job.respond_to?(:sidekiq_options) ? job.sidekiq_options['queue'].to_s : 'default'

      if params['submit'] == 'enqueue'
        case
        when job < ActiveJob::Base
          job.perform_later(*job_params.values)
        when job_klass.included_modules.include?(Sidekiq::Worker)
          Sidekiq::Client.enqueue_to(queue, job, *job_params.values)
        end
      elsif params['submit'] == 'schedule'
        case
        when job < ActiveJob::Base
          job.set(wait: params['enqueue_in'].to_i.seconds).perform_later(*job_params.values)
        when job_klass.included_modules.include?(Sidekiq::Worker)
          Sidekiq::Client.enqueue_to_in(
            queue, params['enqueue_in'].to_i.seconds, job, *job_params.values
          )
        end
      end
    end
    # rubocop:enable Metrics/AbcSize

    # @return [void]
    #
    # @api public
    # @since 0.1.0
    def load
      if defined?(Sidekiq::Web)
        Sidekiq::Web.register(SidekiqAdminEnquerer::WebApp)
        Sidekiq::Web.tabs['Enqueuer'] = 'enqueuer'
      end
    end
  end
end
