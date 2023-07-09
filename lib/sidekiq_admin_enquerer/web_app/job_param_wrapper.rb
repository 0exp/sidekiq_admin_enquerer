# frozen_string_literal: true

# @api private
# @since 0.1.0
class SidekiqAdminEnquerer::WebApp::JobParamWrapper
  # @return [Symbol]
  #
  # @api private
  # @since 0.1.0
  attr_reader :name

  # @return [Class<ActiveJob::Base>, Class<Sidekiq::Worker>]
  #
  # @api private
  # @since 0.1.0
  attr_reader :job

  # @return [Symbol]
  #
  # @api private
  # @since 0.1.0
  attr_reader :req

  # @param job [Class<ActiveJob::Base>, Class<Sidekiq::Worker>]
  # @param method [Symbol]
  # @param name [Symbol]
  # @param req [Symbol]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(job, method, name, req)
    @job = job
    @name = name
    @req = req
  end

  # @return [Boolean]
  #
  # @api private
  # @since 0.1.0
  def optional?
    req == :key || req == :opt
  end

  # @return [Boolean]
  #
  # @api private
  # @since 0.1.0
  def required?
    req == :keyreq || req == :req
  end

  # @return [Boolean]
  #
  # @api private
  # @since 0.1.0
  def kwarg_attr?
    req == :key || req == :keyreq
  end

  # @return [Boolean]
  #
  # @api private
  # @since 0.1.0
  def named_attr?
    req == :opt || req == :req
  end
end
