class HealthController < ActionController::API
  def show
    render json: { status: "ok", version: "1" }
  end
  def protocol
    render json: { version: 1, compatible: true }
  end
end
