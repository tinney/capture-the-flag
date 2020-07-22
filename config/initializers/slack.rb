if ENV["SLACK_API_TOKEN"].present?
  Slack.configure do |config|
    config.token = ENV["SLACK_API_TOKEN"]
  end
elsif Rails.env.production?
  raise "Environment variable SLACK_API_TOKEN was not set but is required to run the app in production"
end