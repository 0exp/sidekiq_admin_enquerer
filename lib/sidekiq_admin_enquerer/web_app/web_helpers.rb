# frozen_string_literal: true

# @api private
# @since 0.1.0
module SidekiqAdminEnquerer::WebApp::WebHelpers
  # @param job [SidekiqAdminEnquerer::WebApp::JobWrapper]
  # @return [String]
  #
  # @api private
  # @since 0.1.0
  def side_enq__enqueue_path(job)
    "#{root_path}enqueuer/#{job.name}"
  end

  # @return [String]
  #
  # @api private
  # @since 0.1.0
  def side_enq__enqueue_job_path
    "#{root_path}enqueuer"
  end

  # @param job_method [SidekiqAdminEnquerer::WebApp::JobMethodWrapper]
  # @return [String]
  #
  # @api private
  # @since 0.1.0
  def side_enq__method_params(job_method)
    job_method.params.map(&:name).join(', ')
  end

  # @param job_param [SidekiqAdminEnquerer::WebApp::JobParamWrapper]
  # @return [String]
  #
  # @api private
  # @since 0.1.0
  def side_enq__param_requirement(job_param)
    job_param.required? ? 'required' : 'optional'
  end
end
