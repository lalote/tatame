# frozen_string_literal: true

class NotAuthorizedException < StandardError; end

module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user

    before_action :authenticate_user

    rescue_from NotAuthorizedException, with: -> { render json: { error: 'Not Authorized' }, status: :unauthorized }
  end

  private

  def authenticate_user
    @current_user = DecodeAuthenticationCommand.call(request.headers).result
    raise NotAuthorizedException unless @current_user
  end
end

Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImxhbG90ZUBnbWFpbC5jb20iLCJhZG1pbiI6ZmFsc2UsImV4cCI6MTU0MzY5NzE2OH0.6OlJcQf8Q-uIMAS_32bQYtiOg8ya13BESYMD-u83zy0