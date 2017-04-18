require_relative '../spec_helper'
require './app/services/word_frequency_validator'

describe WordFrequencyValidator, type: :service do

  text = "The quick brown fox jumped over the lazy dog."
  exclude = ["quick", "brown", "lazy"]
  correct_answer = {
      "The" => 2,
      "fox" => 1,
      "jumped" => 1,
      "over" => 1,
      "dog" => 1
  }
  cookie = CookieHashHandler.new(text, exclude).cookie_hash
  it 'should properly validate a correct answer' do
    expect(WordFrequencyValidator.new(text, exclude, correct_answer, cookie).valid?).to be_truthy
  end

  it 'should properly invalidate an incorrect answer' do
    incorrect_answer = Hash[correct_answer.map { |k, v| [k, v += 1] }]
    expect(WordFrequencyValidator.new(text, exclude, incorrect_answer, cookie).valid?).to be_falsey
  end
end