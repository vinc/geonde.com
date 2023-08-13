class ApplicationController < ActionController::Base
  def record_not_found(error)
    render json: { error: "Not Found" }, status: :not_found
  end
end
