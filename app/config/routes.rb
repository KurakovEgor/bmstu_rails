Rails.application.routes.draw do
  get 'perfect_numbers/check_sequence_input'
  #post 'perfect_numbers/send_n'
  root 'perfect_numbers#check_sequence_input'
  post 'perfect_numbers/check_sequence_input_array'
  post 'perfect_numbers/get_result'
end
