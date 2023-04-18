class ApplicationController < ActionController::API

  class UnauthorizedError < StandardError; end
  rescue_from UnauthorizedError do |exception|
    render status: 401, json: { error: exception.message }
  end

  def health
    if $redis.get("simulate_health_failure")
      head 500
    else
      head 200, content_type: "json"
    end
  end

  def ready
    if $redis.get("simulate_readiness_failure")
      head 500
    else
      head 200, content_type: "json"
    end
  end

  def ping
    render json: "pong"
  end

  def increase_memory
    10000000.times.each do |time|
      $in_memory_data << $random_data
    end
    render json: "inserted"
  end

  def in_memory_data_length
    render json: $in_memory_data.length
  end

  def set_redis_data
    $redis.set("random", SecureRandom.uuid)
    render json: "inserted"
  end

  def get_redis_data
    render json: $redis.get("random")
  end

  def simulate_health_failure
    $redis.set("simulate_health_failure", true)
    render json: "OK"
  end

  def simulate_readiness_failure
    $redis.set("simulate_readiness_failure", true)
    render json: "OK"
  end

  protected

    def not_found!
      raise ActionController::RoutingError.new('Not Found')
    end

    def unauthorized!
      raise UnauthorizedError.new("Unauthorized")
    end
end
