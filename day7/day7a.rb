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

lines = File.read('input.txt').split("\n")

dag = DAG.new

lines.each do |line|
  m = /(\w)\smust\sbe\sfinished\sbefore\sstep\s(\w)/.match(line)
  v1 = dag.find_or_create_vertex_by(:name, m[1])
  v2 = dag.find_or_create_vertex_by(:name, m[2])
  dag.add_edge from: v1, to: v2
end

def traverse(vertices, path=[])
  if vertices.length == 0
    path
  else
    sv = vertices.sort { |x,y| x[:name] <=> y[:name] }
    v = sv.detect do |sat|
      sat.predecessors - path == []
    end
    path << v unless path.include?(v)
    v.successors.each { |s| vertices << s unless vertices.include?(s) }
    vertices = vertices - [v]
    traverse(vertices, path)
  end
end

puts traverse(dag.origins).map { |v| v[:name] }.join('')


