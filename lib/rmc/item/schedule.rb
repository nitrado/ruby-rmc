
module RMC::Item

  class Schedule

    attr_accessor :connection

    attr_reader :id
    attr_reader :name
    attr_reader :status

    attr_reader :frequency
    attr_reader :recur
    attr_reader :startTime
    attr_reader :month
    attr_reader :year

    attr_reader :dayofweek
    attr_reader :dayofmonth

    attr_reader :nextRunTime

    attr_reader :appType
    attr_reader :resourceCategory
    attr_reader :resourceList

    def initialize(connection, data)
      @connection = connection

      @id = data['id']
      @name = data['name']
      @status = data['status']

      @frequency = data['frequency']
      @recur = data['recur']
      @startTime = data['startTime']
      @month = data['month']
      @year = data['year']

      @dayofweek = data['dayofweek']
      @dayofmonth = data['dayofmonth']

      @nextRunTime = data['nextRunTime']

      @appType = data['appType']
      @resourceCategory = data['resourceCategory']
      @resourceList = data['resourceList']
    end

    def delete
      @connection.request(
          :url => "/schedule-jobs/#{@id}",
          :method => :delete,
      )
    end

  end

end