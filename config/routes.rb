Rails.application.routes.draw do
  get '/health', to: 'application#health'
  get '/ready', to: 'application#ready'
  get '/ping', to: 'application#ping'
  get '/simulate_health_failure', to: 'application#simulate_health_failure'
  get '/simulate_readiness_failure', to: 'application#simulate_readiness_failure'
  get '/increase_memory', to: 'application#increase_memory'
  get '/in_memory_data_length', to: 'application#in_memory_data_length'
  get '/set_redis_data', to: 'application#set_redis_data'
  get '/get_redis_data', to: 'application#get_redis_data'
end
