require 'finding_perfect'

class PerfectNumbersController < ApplicationController
  #def check_sequence
  #  redirect_to action: 'check_sequence_input'
  #end
  
  def check_sequence_input
  end

  #def send_n
    #render plain: params[:n].inspect
  #end

  def check_sequence_input_array
    @length_of_array = params[:n].to_i
  end

  def get_result
    @numbers = []
    params[:input_numbers].each { |k, v| @numbers.push(v.to_i) }
  end
end
