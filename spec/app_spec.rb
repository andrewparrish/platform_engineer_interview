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

  it "returns 200 for a correct answer" do
    post '/', { text: "Call me Ishmael.", exclude: ["Ishmael"], answer: { "call" => 1, "me" => 1 }}
    expect(last_response.status).to eql 200
  end

  it "returns 400 for an incorrect answer" do
    post '/', { text: "Call me Ishmael.", exclude: ["Ishmael"], answer: { "call" => 2, "me" => 1 }}
    expect(last_response.status).to eql 400
  end
end