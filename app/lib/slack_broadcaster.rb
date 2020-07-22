class SlackBroadcaster
  def self.broadcast_award(award)
    return if Rails.env.test?  # don't broadcast in test mode

    client = Slack::Web::Client.new
    client.chat_postMessage(channel: SLACK_CHANNEL_NAME, text: award.message)
  end
end