module Mailgun
  class APIClient

    def execute_request(http_verb, url, payload_params={})
      response = if http_verb == :get
        HTTParty.get(url, :query => payload_params)
      else
        HTTParty.post(url, :query => payload_params)
      end
      return response
    end

    def base_url
      "https://"+Rails.application.secrets.mailgun_key+"@"+Settings.mailgun.url_domain
    end

  end
end