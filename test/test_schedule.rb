# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 16 July 2014

require File.expand_path('../../lib/citrus-scheduler', __FILE__)

def simple_job_cb args={}
  puts "simple job #{args[:id]} with interval: #{args[:interval]} executed at #{Time.now}"
end

def test_simple_job_schedule count
  count.times do |count|
    start_time = Time.now.to_f + rand * 10
    interval = rand * 60 + 0.1
    args = [
      method(:simple_job_cb),
      { :id => count, :interval => interval },
      { :start_time => start_time, :interval => interval }
    ]
    CitrusScheduler.schedule_job *args
  end
end

def test
  test_simple_job_schedule 5
end

EM.run { test }
