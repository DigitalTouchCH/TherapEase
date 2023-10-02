class ErrorsController < ApplicationController
  skip_after_action :verify_authorized
  skip_before_action :authenticate_user!

  def not_found
    render status: 404
  end

  def internal_server_error
    render status: 500
  end

  def unprocessable
    render status: 422
  end

  def unacceptable
    render status: 406
  end
end
