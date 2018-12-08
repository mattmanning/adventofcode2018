require 'dag'

class DAG
  def find_vertex_by(sym, val)
    vertices.detect { |v| v[sym] == val }
  end

  def find_or_create_vertex_by(sym, val)
    find_vertex_by(sym, val) || add_vertex({sym => val})
  end

  def origins
    vertices.select { |v| v.predecessors.length == 0 }
  end
end

class DAG::Vertex
  def time
    ('A'..'Z').to_a.index(self[:name]) + 61
  end
end

class Job
  attr_accessor :vertex, :time

  def initialize(vertex)
    @vertex = vertex
    @time = vertex.time
  end

  def tick
    self.time -= 1
    vertex[:name]
  end

  def finished?
    time == 0
  end
end

class Worker
  attr_accessor :job, :queue, :log, :path

  def initialize(queue, path)
    @queue = queue
    @path = path
    @log = ''
  end

  def tick
    get_job if job.nil?
    if job
      self.log += job.tick
    else
      self.log += '.'
    end
  end

  def get_job
    temp = []

    while j = @queue.shift
      if j.vertex.predecessors - path == []
        self.job = j
        break
      else
        temp.push j
      end
    end

    @queue.unshift(*temp)
  end

  def job_finished?
    job && job.finished?
  end

  def vertex
    job.vertex if job
  end
end

lines = File.read('input.txt').split("\n")

dag = DAG.new

lines.each do |line|
  m = /(\w)\smust\sbe\sfinished\sbefore\sstep\s(\w)/.match(line)
  v1 = dag.find_or_create_vertex_by(:name, m[1])
  v2 = dag.find_or_create_vertex_by(:name, m[2])
  dag.add_edge from: v1, to: v2
end

jobs = []
seen = []
path = []
ticks = 0

def push_job(queue, vertex, seen)
  seen.push(vertex)
  job = Job.new(vertex)
  queue.push(job)
end

dag.origins.each do |v|
  push_job(jobs, v, seen)
end

workers = []
5.times do
  workers.push Worker.new(jobs, path)
end

while true
  workers.each(&:tick)
  workers.each do |worker|
    if worker.job_finished?
      vertex = worker.job.vertex
      worker.job = nil
      path << vertex
      successors = (vertex.successors - seen).sort { |a,b| a[:name] <=> b[:name] }
      successors.each { |s| push_job(jobs, s, seen) }
    end
    #workers.each {|worker| puts worker.log}
  end
  break if jobs.length == 0 && !workers.any? {|w| w.job}
  ticks += 1
end

puts ticks + 1
