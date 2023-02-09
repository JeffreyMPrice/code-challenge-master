class ApplicationController < ActionController::API
  rescue_from('::Exception') { |exception| rescue_me!(exception) }
  before_action :force_json_format, :set_standard_response_headers

  def root
    render json: { status: 200, message: I18n.translate(:root_message) }
  end

  private

  def rescue_me!(exception)
    presenter = ExceptionPresenter.new(exception)
    render json: presenter.json_payload, status: presenter.status_code
  end

  def force_json_format
    request.format = :json
    params[:format] = 'json'
  end

  def set_standard_response_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Content-Type'] = 'application/json charset=utf-8'
    response.headers['X-Server-Date'] = DateTime.now.to_timestamp(timezone: AppDefaults::TIMEZONE)
    response.headers['P3P'] = 'CP="NOI ADM DEV COM NAV OUR STP"'
    response.headers['TSV'] = 'T'
  end
end
