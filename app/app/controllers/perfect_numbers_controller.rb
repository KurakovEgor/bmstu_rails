require 'finding_perfect'

class PerfectNumbersController < ApplicationController

  def index; end

  def result
    numbers = []
    params[:input_numbers].each { |_, v| numbers.push(v.to_i) }
    @sequences = perfect_seqs(numbers)
    @longest_seq = longest_seq(@sequences)
    respond_to do |format|
      format.json do
        render json: {
            error: @error,
            sequences: @sequences,
            longest_seq: @longest_seq
        }
      end
    end
  end
end
