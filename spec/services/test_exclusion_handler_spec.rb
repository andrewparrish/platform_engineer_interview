require_relative '../spec_helper'
require "./app/services/text_exclusion_handler"

describe TextExclusionHandler, type: :service do

  it 'return an empty array if there is only one unique word' do
    expect(TextExclusionHandler.new("test test test").exclude).to eql []
  end

  it 'returns a non-empty array if there is more than one unique word' do
    expect(TextExclusionHandler.new("test a b c d").exclude.count).to be >= 1
  end
end