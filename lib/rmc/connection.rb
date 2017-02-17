
module RMC
  class Connection

    attr_reader :url
    attr_reader :token

    attr_accessor :logger

    def initialize(url, username, password, verify_ssl = true)
      @url = "#{url}/rest/rm-central/v1"
      @verify_ssl = verify_ssl
      @logger = Logger.new('/dev/null')
      Oj.default_options = {
          :mode => :compat
      }

      create_token(username, password)
    end

    def request(params)
      data = {
          method: :get,
          timeout: 10,
          verify_ssl: @verify_ssl,
      }.merge(params)

      data[:url] = "#{@url}#{data[:url]}"

      unless data.has_key?(:headers)
        data[:headers] = {}
      end

      data[:headers] = {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json',
      }

      # If payload provided, encode it
      if data[:payload]
       data[:payload] = Oj.dump(data[:payload])
      end

      if @token
        data[:headers]['X-Auth-Token'] = @token
      end

      @logger.info("RMC: Request: #{data}")

      begin
        result = Oj.safe_load(RestClient::Request.execute(data))
        @logger.info("RMC: Result: #{result}")

        result
      rescue RestClient::Exception => e
        if e.http_code == 401
          raise RMC::LoginException, e.http_body
        end

        if e.http_code == 404
          raise RMC::NotFoundException, e.http_body
        end

        raise RMC::Exception, e.http_body
      rescue Oj::Error => e
        raise RMC::Exception, e.to_s
      end
    end

    def wait_for_task(id)

      begin
        Timeout.timeout(1800) do
          result = request(
              :url => "/tasks/#{id}"
          )['task']
          state = result['taskState']

          while state == 'Running'
            sleep(1)

            @logger.debug("RMC: Checking Task #{id} State...")
            result = request(
                :url => "/tasks/#{id}"
            )['task']

            state = result['taskState']
          end

          if state == 'Completed'
            @logger.debug("RMC: Task #{id} completed...")
            return result
          end

          raise RMC::Exception, "Task #{id} failed, got state #{state}"
        end
      rescue TimeoutError
        raise RMC::Exception, "Task #{id} timeout"
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
          url: "/login-sessions",
          payload: data,
          method: :post
      )

      @token = response['loginSession']['access']['token']['id']
    end

  end
end