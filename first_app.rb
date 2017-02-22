require 'sinatra'
require 'sqlite3'
require 'active_record'
require_relative 'lipsum'
require_relative 'migration'

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "development.sqlite3"
)

list = Lipsum.pluck(:name)

get "/" do
  "Hello World!"
end

get "/:name" do
  if params[:name] == 'lorem'
    list.map{ |lip| "<p>/#{lip}</p>"}
  else
    "The force be with you, #{params[:name]}."
  end
end

get "/lorem/:lip/?:n?" do
  n = params[:n].to_i == 0 ? 1 : params[:n].to_i
  Lipsum.find_by(name: params[:lip]).text*n
end
