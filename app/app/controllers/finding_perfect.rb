def get_dividers(number)
  dividers = []
  (number - 1).downto(1) { |i| (number % i).zero? && dividers.push(i) }
  dividers
end

def perfect?(number)
  get_dividers(number).inject(0) { |result, elem| result + elem } == number
end

def perfect_seqs(seq_of_numbers)
  result_sequences = [[]]
  prev_is_perfect = false
  seq_of_numbers.each { |i|
    if perfect? i
      result_sequences.last.push(i)
      prev_is_perfect = true
    elsif prev_is_perfect
      result_sequences.push([])
      prev_is_perfect = false
    end
  }
  result_sequences.select(&:any?)
end

def longest_seq(seq_of_seq)
  seq_of_seq.max_by(&:length)
end
