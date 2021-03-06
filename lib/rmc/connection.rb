
module RMC
  class Connection

    attr_reader :url
    attr_reader :token
    attr_writer :version

    attr_accessor :logger

    def initialize(url, username, password, verify_ssl = true, version = 1)
      @url = "#{url}/rest/rm-central/"
      @version = version
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
          timeout: 60,
          verify_ssl: @verify_ssl,
      }.merge(params)

      data[:url] = "#{@url}v#{@version}#{data[:url]}"

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
      @version = 2
      begin
        Timeout.timeout(1800) do
          while true
            begin
              result = request(
                  :url => "/tasks/#{id}"
              )['task']
              break
            rescue RMC::NotFoundException
              @logger.info("RMC: Task #{id} not found, waiting...")
              sleep(5)
            end
          end

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
      rescue Timeout::Error
        raise RMC::Exception, "Task #{id} timeout"
      ensure
        @version = 1
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