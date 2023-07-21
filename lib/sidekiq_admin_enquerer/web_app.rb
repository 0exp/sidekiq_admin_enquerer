# frozen_string_literal: true

# @api private
# @since 0.1.0
module SidekiqAdminEnquerer::WebApp
  require_relative 'web_app/web_helpers'
  require_relative 'web_app/job_param_wrapper'
  require_relative 'web_app/job_method_wrapper'
  require_relative 'web_app/job_wrapper'
  require_relative 'web_app/app_control'

  # @return [Hash<Symbol,String>]
  #
  # @api private
  # @since 0.1.0
  TEMPLATES = {
    jobs: File.read(File.join(File.expand_path(__dir__), 'pages', 'jobs.erb')),
    job: File.read(File.join(File.expand_path(__dir__), 'pages', 'job.erb'))
  }.freeze

  class << self
    # @param app [?]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def registered(app)
      app.helpers(WebHelpers)

      app.get('/enquerer') do
        @jobs = AppControl.jobs
        render(:erb, TEMPLATES[:jobs])
      end

      app.get('/enquerer/:job_name') do
        @job = AppControl.find_job(params[:job_name])
        render(:erb, TEMPLATES[:job])
      end

      app.post('/enquerer') do
        AppControl.run_job(params)
        redirect File.join(root_path, 'enquerer')
      end
    end
  end
end
