# frozen_string_literal: true

# @api private
# @since 0.1.0
class SidekiqAdminEnquerer::WebApp::JobWrapper
  # @return [Array<SidekiqAdminEnquerer::WebApp::JobMethodWrapper>]
  #
  # @api private
  # @since 0.1.0
  attr_reader :methods

  # @param job [Class<ActiveJob::Base>, Class<Sidekiq::Worker>]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(job)
    @job = job
    @methods = SidekiqAdminEnquerer::WebApp::JobMethodWrapper.extract_methods_from(job)
  end

  # @return [String]
  #
  # @api private
  # @since 0.1.0
  def name
    job.name
  end

  private

  # @return [Class<ActiveJob::Base>, Class<Sidekiq::Worker>]
  #
  # @api private
  # @since 0.1.0
  attr_reader :job
end
