require 'test_helper'

class PerfectNumbersControllerTest < ActionDispatch::IntegrationTest
  BASE_URL = 'http://localhost:3000'.freeze

  test 'should get index' do
    visit BASE_URL
    page.assert_selector '#n'
    page.assert_no_text 'span.error'
    page.assert_no_text 'div.result'
    page.assert_no_text '#form'
  end

  test 'check rss format' do
    get perfect_numbers_result_url(input_numbers: %w'1 2 3 4 5 6 7 8 9 10', format: :rss)
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/rss'
  end

  test 'check xml format' do
    get perfect_numbers_result_url(input_numbers: %w'1 2 3 4 5 6 7 8 9 10', format: :xml)
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/xml'
  end

  test 'should get no perfect numbers from 1' do
    visit BASE_URL

    fill_in 'Введите количество чисел в последовательности:', with: '1'
    click_button 'Ввести!'

    page.assert_no_text 'div.result'
    page.assert_no_text 'span.error'
    numbers = page.find('#form div.data').all('input[type="number"]')
    assert_equal 1, numbers.length

    fill_in class: 'A0', with: '1'
    click_button 'Ввести'

    page.find('.result').assert_text 'Результаты:

Самая длинная последовательность совершенных чисел: Не нашлось самой длинной последовательности

Последовательности совершенных чисел:

№	Последовательность
Не нашлось ни одной последовательности'
  end

  test 'should get one perfect number from 1..10' do
    visit BASE_URL

    fill_in 'Введите количество чисел в последовательности:', with: '10'
    click_button 'Ввести!'

    page.assert_no_text 'div.result'
    page.assert_no_text 'span.error'
    numbers = page.find('#form div.data').all('input[type="number"]')
    assert_equal 10, numbers.length

    fill_in class: 'A0', with: '1'
    fill_in class: 'A1', with: '2'
    fill_in class: 'A2', with: '3'
    fill_in class: 'A3', with: '4'
    fill_in class: 'A4', with: '5'
    fill_in class: 'A5', with: '6'
    fill_in class: 'A6', with: '7'
    fill_in class: 'A7', with: '8'
    fill_in class: 'A8', with: '9'
    fill_in class: 'A9', with: '10'
    click_button 'Ввести'

    result = page.find('.result')
    result.assert_text 'Результаты:

Самая длинная последовательность совершенных чисел: 6

Последовательности совершенных чисел:

№	Последовательность
1	6'
  end

  test 'should get sequence of 4 perfect numbers from [6,6,1,6,6,6,6]' do
    visit BASE_URL

    fill_in 'Введите количество чисел в последовательности:', with: '7'
    click_button 'Ввести!'

    page.assert_no_text 'div.result'
    page.assert_no_text 'span.error'
    numbers = page.find('#form div.data').all('input[type="number"]')
    assert_equal 7, numbers.length

    fill_in class: 'A0', with: '6'
    fill_in class: 'A1', with: '6'
    fill_in class: 'A2', with: '1'
    fill_in class: 'A3', with: '6'
    fill_in class: 'A4', with: '6'
    fill_in class: 'A5', with: '6'
    fill_in class: 'A6', with: '6'
    click_button 'Ввести'

    result = page.find('.result')
    result.assert_text 'Результаты:

Самая длинная последовательность совершенных чисел: 6, 6, 6, 6

Последовательности совершенных чисел:

№	Последовательность
1	6, 6
2	6, 6, 6, 6'
  end
end
