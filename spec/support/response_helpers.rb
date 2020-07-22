module Support
  module ResponseHelpers
    def response_json
      body = response.body
      body.empty? ? nil : JSON.parse(body)
    end
  end
end
