class SlackBroadcaster
  def self.broadcast_award(award)
  end
  
  def self.send_request(api_endpoint, options)
    result_key_map = {
      "users_lookupByEmail" => "user",
      "im_open" => "channel"
    }
    begin
      result = client.send(api_endpoint, options)
      result = result[result_key_map[api_endpoint]] if result_key_map[api_endpoint]
    rescue Slack::Web::Api::Errors::SlackError => e
      Bugsnag.leave_breadcrumb("API Details", options.merge(endpoint: api_endpoint))
      Bugsnag.notify(e)
      result = {}
    end
    result
  end
end