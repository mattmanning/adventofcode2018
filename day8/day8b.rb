input = File.read('input.txt').chomp
data = input.split(' ').map(&:to_i)

class Node
  attr_accessor :child_count, :children, :meta_count, :meta

  def sum_meta
    meta.sum + children.inject(0) do |s, child|
      s + child.sum_meta
    end
  end

  def value
    if child_count == 0
      meta.sum
    else
      meta.inject(0) do |s, m|
        if (m > 0) && children[m-1]
          s + children[m-1].value
        else
          s
        end
      end
    end
  end     
end

def parse(arr)
  node = Node.new
  node.child_count = arr.shift
  node.children = Array.new(node.child_count, nil)
  node.meta_count = arr.shift
  if node.child_count != 0
    node.children = node.children.map do |child|
      child = parse(arr)
    end
  end
  node.meta = arr.shift(node.meta_count)
  node
end

top_node = parse(data)
puts top_node.value
