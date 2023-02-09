class ExceptionPresenter
  attr_reader :exception, :status_code, :json_payload

  def initialize(exception)
    @exception = exception
    @status_code = 500
    @json_payload = {}
    create_json_payload
    log_error
  end

  private

  def log_error
    Rails.logger.error("\n========== EXCEPTION [#{DateTime.now.to_timestamp}] : #{exception.class.name} #{exception.message}\n#{backtrace_string}\n")
  end

  def backtrace_array
    exception.backtrace.slice(0, AppDefaults::MAX_BACKTRACE)
  end

  def backtrace_string
    backtrace_array.map { |bt| "~~> #{bt}" }.join("\n")
  end

  def create_json_payload
    if exception.is_a?(ActionController::RoutingError) || exception.is_a?(NotImplementedError)
      @status_code = 421
      @json_payload[:error] = 'not_implemented'
      @json_payload[:error_description] = I18n.translate('errors.not_implemented')
    elsif exception.is_a?(ActiveRecord::RecordNotFound)
      @status_code = 404
      @json_payload[:error] = 'not_found'
      @json_payload[:error_description] = I18n.translate('errors.not_found')
    elsif exception.is_a?(ActionDispatch::Http::Parameters::ParseError)
      @status_code = 400
      @json_payload[:error] = 'invalid_request'
      @json_payload[:error_description] = I18n.translate('errors.unsupported_parameter')
    else
      @status_code = 500
      @json_payload[:error] = 'internal_server_error'
      @json_payload[:error_description] = I18n.translate('errors.internal')
    end

    if Rails.env.development?
      @json_payload[:dev_message] = exception.message
      @json_payload[:dev_backtrace] = backtrace_array
    end
    @json_payload[:status] = status_code
  end
end
