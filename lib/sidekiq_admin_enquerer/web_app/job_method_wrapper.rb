# frozen_string_literal: true

# @api private
# @since 0.1.0
class SidekiqAdminEnquerer::WebApp::JobMethodWrapper
  # @return [Array<Symbol>]
  #
  # @api private
  # @since 0.1.0
  JOB_INVOCATION_METHODS = %i[
    perform
    perform_in
    perform_async
    perform_at
  ].freeze

  class << self
    # @param job [Class<ActiveJob::Base>, Class<Sidekiq::Worker]
    # @return [Array<SidekiqAdminEnquerer::WebApp::JobMethodWrapper>]
    #
    # @api private
    # @since 0.1.0
    def extract_methods_from(job)
      job.instance_methods.select do |method|
        JOB_INVOCATION_METHODS.include?(method)
      end.each_with_object([]) do |method, aggregate|
        parameters = job.instance_method(method).parameters.map do |(req, name)|
          SidekiqAdminEnquerer::WebApp::JobParamWrapper.new(job, method, name, req)
        end # => Array<JobParamWrapper>
        aggregate << new(job, method, parameters) # => JobMethodWrapper
      end
    end
  end

  # @return [Class<ActiveJob::Base>, Class<Sidekiq::Worker>]
  #
  # @api private
  # @since 0.1.0
  attr_reader :job

  # @return [Symbol]
  #
  # @api private
  # @since 0.1.0
  attr_reader :name

  # @return [Array<SidekiqAdminEnquerer::WebApp::JobParamWrapper>]
  #
  # @api private
  # @since 0.1.0
  attr_reader :params

  # @param job [Class<ActiveJob::Base>, Class<Sidekiq::Worker>]
  # @param name [Symbol]
  # @param params [Array<SidekiqAdminEnquerer::WebApp::JobParamWrapper>]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(job, name, params)
    @job = job
    @name = name
    @params = params
  end
end
