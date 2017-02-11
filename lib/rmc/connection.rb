
module RMC
  class Connection

    attr_reader :url
    attr_reader :token

    def initialize(url, username, password, verify_ssl = true)
      @url = "#{url}/rest/rm-central/v1"
      @verify_ssl = verify_ssl

      create_token(username, password)
    end

    def request(params)
      data = {
          method: :get,
          timeout: 10,
          verify_ssl: @verify_ssl,
      }.merge(params)

      unless data.has_key?(:headers)
        data[:headers] = {}
      end

      data[:headers] = {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json',
      }

      # If payload provided, encode it
      if data[:payload]
       data[:payload] = JSON.dump(data[:payload])
      end

      if @token
        data[:headers]['X-Auth-Token'] = @token
      end

      begin
        JSON.parse(RestClient::Request.execute(data))
      rescue RestClient::Exception => e
        if e.http_code == 401
          raise RMC::LoginException, e.http_body
        end

        raise RMC::Exception, e.http_body
      end
    end

    private

    def create_token(username, password)
      data = {
          auth: {
              passwordCredentials: {
                  username: username,
                  password: password
              }
          }
      }

      response = request(
          url: "#{@url}/login-sessions",
          payload: data,
          method: :post
      )

      @token = response['loginSession']['access']['token']['id']
    end

  end
end