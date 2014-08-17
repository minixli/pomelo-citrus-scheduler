# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 15 July 2014

require 'algorithms'
require 'citrus-scheduler/job'

module CitrusScheduler
  @jobs_map = {}
  @jobs_queue = Containers::PriorityQueue.new
  @timer = nil
  @accuracy = 0.01

  # Schedule a new job
  #
  # @param [#call] job_cb
  # @param [Hash]  job_cb_args
  # @param [Hash]  trigger_args
  def self.schedule_job job_cb, job_cb_args={}, trigger_args={}
    job = Job.new job_cb, job_cb_args, trigger_args
    job_id = job.job_id
    execute_time = job.execute_time

    @jobs_map[job_id] = job
    element = {
      :job_id => job_id,
      :execute_time => execute_time
    }

    cur_job = @jobs_queue.next
    unless cur_job && execute_time >= cur_job[:execute_time]
      @jobs_queue.push element, -execute_time
      set_timer job
      return job_id
    end

    @jobs_queue.push element, -execute_time
    return job_id
  end

  # Cancel a job
  #
  # @param [Integer] job_id
  def self.cancel_job job_id
    cur_job = @jobs_queue.next
    if cur_job && job_id == cur_job[:job_id]
      @jobs_queue.pop
      @jobs_map.delete job_id
      @timer.cancel
      execute_job
    end
    @jobs_map.delete job_id
    true
  end

  # Clear last timeout and schedule the next job, it will automatically
  # run the job that need to run now
  #
  # @param [Object] job
  def self.set_timer job
    @timer.cancel if @timer
    @timer = EM::Timer.new(job.execute_time - Time.now.to_f) {
      execute_job
    }
  end

  # Execute job
  def self.execute_job
    job = peek_next_job

    while job && (job.execute_time - Time.now.to_f) < @accuracy
      job.run
      @jobs_queue.pop

      next_time = job.next_execute_time

      if next_time
        element = {
          :job_id => job.job_id,
          :execute_time => next_time
        }
        @jobs_queue.push element, -next_time
      else
        @jobs_map.delete job.job_id
      end
      job = peek_next_job
    end

    return unless job
    set_timer job
  end

  # Peek next job
  def self.peek_next_job
    return nil if @jobs_queue.size <= 0

    job = nil
    loop do
      job = @jobs_map[@jobs_queue.next[:job_id]]
      @jobs_queue.pop unless job
      break if job || @jobs_queue.size <= 0
    end
    job
  end

  # Get next job
  def self.get_next_job
    job = nil
    while !job && @jobs_queue.size > 0
      job = @jobs_map[@jobs_queue.pop[:job_id]]
    end
    job
  end
end
