require 'sinatra'
require "sinatra/reloader" if development?

set :root, File.join(Dir.pwd, "app")
set :views, Proc.new { File.join(root, "views") }


get '/' do
  source_text = TextSampler.new.randomize_file.text.strip
  text_array = source_text.split

  exclude = []
  for i in ((text_array.length-5)...(text_array.length))
    exclude << text_array[i]
  end

  erb :"get.json", locals: { source_text: source_text, exclude: exclude }
end