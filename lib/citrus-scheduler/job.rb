# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 15 July 2014

require 'citrus-scheduler/cron_trigger'
require 'citrus-scheduler/simple_trigger'

module CitrusScheduler
  # Job
  #
  #
  class Job
    @job_id = 1
    @job_count = 0

    class << self
      attr_accessor :job_id, :job_count
    end

    attr_reader :job_id, :run_time

    # Create a new job
    #
    # @param [#call]        job_cb
    # @param [Hash]         job_cb_args
    # @param [Hash, String] trigger_args
    def initialize job_cb, job_cb_args={}, trigger_args={}
      @job_cb = job_cb
      @job_cb_args = job_cb_args

      if trigger_args.instance_of? Hash
        @type = :simple_job
        @trigger = SimpleTrigger.new trigger_args, self
      elsif trigger_args.instance_of? String
        @type = :cron_job
        @trigger = CronTrigger.new trigger_args, self
      else
      end

      @job_id = Job.job_id
      Job.job_id += 1

      @run_time = 0
    end

    # Run the job
    def run
      begin
        Job.job_count += 1
        @run_time += 1
        @job_cb.call @job_cb_args
      rescue => err
      end
    end

    # Get the current execution time
    def execute_time
      @trigger.execute_time
    end

    # Get the next execution time
    def next_execute_time
      @trigger.next_execute_time
    end
  end
end
