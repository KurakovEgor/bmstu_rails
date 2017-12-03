require 'finding_perfect'

class PerfectNumbersController < ApplicationController

  def check_sequence_input; end

  def check_sequence_input_array
    @length_of_array = params[:n].to_i
  end

  def get_result
    numbers = []
    params[:input_numbers].each { |_, v| numbers.push(v.to_i) }
    @sequences = perfect_seqs(numbers)
    @longest_seq = longest_seq(@sequences)
  end
end
