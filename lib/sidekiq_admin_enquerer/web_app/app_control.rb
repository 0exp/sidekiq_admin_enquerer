# frozen_string_literal: true

module SidekiqAdminEnquerer::WebApp
  # @api private
  # @since 0.1.0
  module AppControl
    class << self
      # @return [Array<SidekiqAdminEnquerer::WebApp::JobWrapper>]
      #
      # @api private
      # @since 0.1.0
      def jobs
        SidekiqAdminEnquerer.jobs.map { JobWrapper.new(_1) }
      end

      # @param job_name [String]
      # @return [SidekiqAdminEnquerer::WebApp::JobWrapper]
      #
      # @api private
      # @since 0.1.0
      def find_job(job_name)
        SidekiqAdminEnquerer.find_job(job_name).yield_self { JobWrapper.new(_1) }
      end

      # @param job_run_params [Hash<Symbol,Any>]
      # @return [void]
      #
      # @api private
      # @since 0.1.0
      def run_job(job_run_params)
        job_name = job_run_params['job_name']
        job_klass = SidekiqAdminEnquerer.find_job(job_name)
        SidekiqAdminEnquerer.run_job(job_klass, job_run_params)
      end
    end
  end
end
