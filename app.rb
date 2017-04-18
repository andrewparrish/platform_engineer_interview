require 'sinatra'
require "sinatra/reloader" if development?
require "sinatra/cookies"

require "./app/services/cookie_hash_handler"
require "./app/services/text_exclusion_handler"
require "./app/services/text_sampler"
require "./app/services/word_frequency_validator"

require "json"

set :root, File.join(Dir.pwd, "app")
set :views, Proc.new { File.join(root, "views")}
set :port, 8000

COOKIES_KEY = :cheat_prevention


get '/' do
  source_text = TextSampler.new.randomize_file.text.strip
  exclude = TextExclusionHandler.new(source_text).exclude
  cookies[COOKIES_KEY] = CookieHashHandler.new(source_text, exclude).cookie_hash

  erb :"get.json", locals: { source_text: source_text, exclude: exclude }
end

post '/' do
  # Support either request using  parameters or json body (expected)
  body = params == {} ? JSON.parse(request.body.read) : params
  WordFrequencyValidator.from_request_params(body, cookies[COOKIES_KEY]).valid? ? (status 200) : (status 400)
end