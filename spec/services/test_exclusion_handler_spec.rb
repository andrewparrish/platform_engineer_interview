require_relative '../spec_helper'
require "./app/services/text_exclusion_handler"

describe TextExclusionHandler, type: :service do

  it 'return an empty array if there is only one unique word' do
    expect(TextExclusionHandler.new("test test test").exclude).to eql []
  end
end