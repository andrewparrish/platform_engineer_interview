require 'sinatra'
require "sinatra/reloader" if development?

set :root, File.join(Dir.pwd, "app")
set :views, Proc.new { File.join(root, "views") }


get '/' do
  source_text = TextSampler.new.randomize_file.text.strip
  exclude = TextExclusionHandler.new(source_text).exclude

  erb :"get.json", locals: { source_text: source_text, exclude: exclude }
end

post '/' do

end