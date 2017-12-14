require 'finding_perfect'

class PerfectNumbersController < ApplicationController
  before_action :parse_params, only: :result

  def index; end

  def result
    numbers = []
    @input_numbers.each { |_, v| numbers.push(v.to_i) }
    @sequences = perfect_seqs(numbers)
    @longest_seq = longest_seq(@sequences)
    data = {
        error: @error,
        sequences: @sequences,
        longest_seq: @longest_seq
    }

    respond_to do |format|
      format.xml { render xml: data }
      format.rss { render xml: data }
      format.json { render json: data }
    end
  end

  protected

  def parse_params
    @input_numbers = params[:input_numbers]
    unless @input_numbers.respond_to? :each and not @input_numbers.kind_of?(Array)
      @input_numbers = {}
      @error = 'Wrong argument type'
    end
  end
end
