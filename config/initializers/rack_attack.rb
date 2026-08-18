class Rack::Attack
  # 1. Set cache store to memory store
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  # 2. Define the path for GraphQL requests
  GRAPHQL_PATH = "/graphql"

  # 3. Limit Request per minute
  throttle("graphql/ip/minute", limit: 100, period: 1.minute) do |request|
    if request.post? && (request.path == "/graphql" || request.path == "/graphiql")
      request.ip
    end
  end

  # 4. Return response JSON, wenn Rate Limit
  self.throttled_responder = lambda do |request|
    match_data = request.env["rack.attack.match_data"] || {}
    period = match_data[:period]
    now = match_data[:epoch_time]

    retry_after = period - (now % period) if period && now

    headers = {
      "Content-Type" => "application/json"
    }
    headers["Retry-After"] = retry_after.to_s if retry_after

    body = {
      error: "Too many requests",
      code: "RATE_LIMITED"
    }

    [429, headers, [body.to_json]]
  end
end