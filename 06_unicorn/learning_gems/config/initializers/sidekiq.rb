# start sidekiq worker:
# sidekiq -C config/sidekiq.yml -e development -d
#
redis_config = YAML.load_file(Rails.root.to_s + "/config/redis.yml")[Rails.env.to_s]
redis_conn = proc {
  Redis.new(url: redis_config)
}

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 5, &redis_conn)
end

Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 10, &redis_conn)
end

# Sidekiq.default_worker_options = { 'backtrace' => true, 'retry' => false }