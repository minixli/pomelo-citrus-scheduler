# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 15 July 2014

module CitrusScheduler
  # SimpleTrigger
  #
  #
  class SimpleTrigger
    # Create a new simple trigger
    #
    # @param [Hash] args Options
    #
    # @option args [Integer] start_time
    # @option args [Integer] interval
    # @option args [Integer] count
    # @option args [Object]  job
    def initialize args={}, job
      @next_time = args[:start_time] || Time.now.to_f
      @interval = args[:interval] || -1
      @count = args[:count] || -1
      @job = job
    end

    # Get the current execution time
    def execute_time
      @next_time
    end

    # Get the next execution time
    def next_execute_time
      if (@count > 0 && @count <= @job.run_time) || @interval <= 0
        return nil
      end
      @next_time += @interval
    end
  end
end
