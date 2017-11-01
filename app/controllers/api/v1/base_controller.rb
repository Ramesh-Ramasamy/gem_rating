module Api
  module V1
    class BaseController < ApplicationController
      layout 'api_v1'
      before_action :add_headers, :except => :cors_preflight
      skip_before_action :verify_authenticity_token, only: [:cors_preflight]

      def cors_preflight
        if request.method.to_s == 'OPTIONS'
          headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"] || "*"
          headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
          headers['Access-Control-Request-Method'] = '*'
          headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, DNT, X-Version-Code, X-Build-Commit'
          headers['Access-Control-Allow-Credentials'] = "true"
          headers['Access-Control-Max-Age'] = '10'
          render plain: 'OK'
        end
      end

      def add_headers
        response.headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"] || "*"
        response.headers['Access-Control-Allow-Credentials'] = "true"
      end

      def render_500(exception)
        Rails.logger.error "ERROR caught in 500 handler\n#{exception.message}\n"+exception.backtrace.join("\n")
        render_error(nil, :error_type => :internal_server_error, :status => 500)
      end

      def render_404()
        render_error(nil, :error_type => "Not Found", :status => 404)
      end

      def render_success(result = nil, options = {})
        @_status = 'success'
        render({plain: result.to_json , layout: true}.merge(options))
      end

      def render_error(errors = nil, options = {})
        set_error(errors, options)
        params[:format] = (request.path.match(/\.(js|xml|json)$/).try('[]', -1) || 'json').to_sym#check this
        render({:text => 'null', :layout => true}.merge(options))
      end

      def set_error(errors = nil, options = {})
        case errors.class.name.demodulize
        when "Errors"
          @_errors = errors.full_messages
        when "String", "Symbol"
          @_errors = [errors]
        else
          @_errors = errors
        end
        @_status = options.delete(:error_type) || :invalid_input
      end

    end
  end
end
