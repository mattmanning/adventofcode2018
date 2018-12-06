require 'date'

TS_REGEX = /\[(.+)\]/
GUARD_REGEX = /Guard\s#(\d+)/
EVENT_REGEX = /(falls\sasleep|begins\sshift|wakes\sup)/

lines = File.read('input.txt').split("\n")

class Sleep
  attr_accessor :guard_id, :start_time, :end_time

  def initialize(guard_id, start_time)
    @guard_id, @start_time = guard_id, DateTime.parse(start_time).to_time
  end

  def wake(time)
    @end_time = DateTime.parse(time).to_time
  end

  def contains?(minute)
    (@start_time.min..@end_time.min-1).cover?(minute)
  end
end

guard_id = nil
sleeps = []

lines.sort.each do |line|
  if g = GUARD_REGEX.match(line)
    guard_id = g[1]
  else
    time = TS_REGEX.match(line)[1]
    case EVENT_REGEX.match(line)[1]
    when 'falls asleep'
      sleeps << Sleep.new(guard_id, time)
    when 'wakes up'
      sleeps.last.wake(time)
    end
  end
end

guard_sleeps = sleeps.group_by {|s| s.guard_id}

guard_scores = {}

guard_sleeps.each do |k, v|
  guard_scores.merge!({k => {}})
  0.upto(59) do |m|
    guard_scores[k].merge!({m => v.select{|s| s.contains?(m)}.count})
  end
end

max_guard = guard_scores.max_by {|k,v| v.values.max}

puts max_guard[0].to_i * max_guard[1].max_by{|k,v| v}[0]
