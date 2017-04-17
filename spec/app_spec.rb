require "./spec/spec_helper"
require "json"
require "pry"

describe 'The Word Counting App' do
  def app
    Sinatra::Application
  end

  it "returns 200 and has the right keys" do
    get '/'
    expect(last_response).to be_ok
    parsed_response = JSON.parse(last_response.body)
    expect(parsed_response).to have_key("text")
    expect(parsed_response).to have_key("exclude")
  end
end