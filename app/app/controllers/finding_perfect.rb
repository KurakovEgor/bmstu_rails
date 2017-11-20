def get_dividers(number)
  dividers = []
  (number - 1).downto(1) { |i| (number % i).zero? && dividers.push(i) }
  dividers
end

def perfect?(number)
  get_dividers(number).inject(0) { |result, elem| result + elem } == number
end
