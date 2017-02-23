require 'sinatra'
require 'sqlite3'
require 'active_record'
require_relative 'lipsum'
require_relative 'migration'

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "development.sqlite3"
)

after do
  ActiveRecord::Base.connection.close
end

def four
  status(404)
  "<p>404: You died of disentary.</p><p>**GAME OVER**</p>"
end


get "/" do
  "Hello World!"
end

get "/not_found" do
  four
end

get "/:name" do
  if params[:name] == 'lorem'
    Lipsum.pluck(:name).map{ |lip| "<p>/#{lip}</p>"}
  else
    "The force be with you, #{params[:name]}."
  end
end

get "/lorem/:lip/?:n?" do
  lip = params[:lip]
  n = params[:n].to_i == 0 ? 1 : params[:n].to_i
  if Lipsum.pluck(:name).include?(lip)
    Lipsum.find_by(name: lip).paragraph*n
  else
    four
  end
end

post "/lorem/new" do
  lip = Lipsum.new(params)
  lip.save ? "<p>you added #{lip.name}</p><p>#{lip.paragraph}</p>" : four
end
