class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: { error: "Not Found" }, status: :not_found
  end
end
