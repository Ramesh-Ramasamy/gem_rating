module ApiHelper

  def prepare_api_headers
    headers = {}
    # headers[:_token] = request.session_options[:id]#not working
    headers
  end
end