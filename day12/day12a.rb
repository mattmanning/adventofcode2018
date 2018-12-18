@notes = {
  '#.##.' => '.',
  '#.#..' => '.',
  '###.#' => '.',
  '..#.#' => '.',
  '....#' => '.',
  '.####' => '.',
  '##.##' => '#',
  '###..' => '#',
  '.###.' => '#',
  '...#.' => '.',
  '.....' => '.',
  '##..#' => '.',
  '.#.#.' => '#',
  '.#.##' => '#',
  '##.#.' => '.',
  '##...' => '.',
  '#####' => '#',
  '#...#' => '.',
  '..##.' => '.',
  '..###' => '.',
  '.#...' => '#',
  '.##.#' => '.',
  '#....' => '.',
  '.#..#' => '.',
  '.##..' => '#',
  '...##' => '#',
  '#.###' => '.',
  '#..#.' => '.',
  '..#..' => '#',
  '#.#.#' => '#',
  '####.' => '#',
  '#..##' => '.'
}

initial_state = '..#..####.##.####...#....#######..#.#..#..#.#.#####.######..#.#.#.#..##.###.#....####.#.#....#.#####'
#initial_state = '#..#.#..##......###...###'


gen = Hash.new('.')

initial_state.split('').each_with_index do |plant, index|
  gen[index] = plant
end

def llcrr(gen, index)
  gen[index-2] + gen[index-1] + gen[index] + gen[index+1] + gen[index+2]
end

def generate(gen)
  new_gen = Hash.new('.')

  i = -1
  while i > (gen.keys.min - 5)
    left = llcrr(gen, i)
    new_gen[i] = @notes[left]
    i -= 1
  end

  i = 0
  while i < (gen.keys.max + 5)
    right = llcrr(gen, i)
    new_gen[i] = @notes[right]
    i += 1
  end
  new_gen
end

def answer(gen)
  gen.inject(0) do |sum, (k,v)|
    if v == '#'
      sum + k
    else
      sum
    end
  end
end

20.times do
  new_gen = generate(gen)
  gen = new_gen
end


puts answer(gen)