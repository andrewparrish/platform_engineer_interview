require 'sinatra'
require "sinatra/reloader" if development?
require "sinatra/cookies"

require "./app/services/cookie_hash_handler"

set :root, File.join(Dir.pwd, "app")
set :views, Proc.new { File.join(root, "views") }

COOKIES_KEY = :cheat_prevention


get '/' do
  source_text = TextSampler.new.randomize_file.text.strip
  exclude = TextExclusionHandler.new(source_text).exclude
  cookies[COOKIES_KEY] = CookieHashHandler.new(source_text, exclude).cookie_hash unless ENV['RACK_ENV'] == 'test'

  erb :"get.json", locals: { source_text: source_text, exclude: exclude }
end

post '/' do
  return status 400 unless CookieHashHandler.new(params['text'], params['exclude']).valid?(cookies[COOKIES_KEY])
  WordFrequencyValidator.from_request_params(params).valid? ? (status 200) : (status 400)
end