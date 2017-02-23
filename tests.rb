require 'rubygems'
require 'bundler/setup'
ENV['RACK_ENV'] = 'test'

require_relative 'first_app'
require 'test/unit'
require 'rack/test'
require 'faker'
require_relative 'lipsum'
require_relative 'migration'
require_relative 'lipsum'

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "development.sqlite3"
)

class FirstAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def setup
      @jsonlip = {
        'pirate' => "{\"name\":\"pirate\",\"paragraph\":\"Schooner lugsail heave down gun fire in the hole broadside hail-shot Shiver me timbers clipper come about. Aye shrouds fire ship heave to lass wench quarter jib chase guns boatswain. Quarterdeck pressgang dead men tell no tales man-of-war scuppers loot black spot stern barque holystone.\\n\"}",
        'kitty' => "{\"name\":\"kitty\",\"paragraph\":\"Immediately regret falling into bathtub stare at ceiling. Vommit food and eat it again groom yourself 4 hours - checked, have your beauty sleep 18 hours - checked, be fabulous for the rest of the day - checked!. Intently stare at the same spot loves cheeseburgers for behind the couch, for i like big cats and i can not lie. Hopped up on catnip human give me attention meow scratch the furniture howl on top of tall thing but scratch the box, or scratch leg; meow for can opener to feed me and chase ball of string. Purr. Go into a room to decide you didn't want to be in there anyway hopped up on catnip. Ignore the squirrels, you'll never catch them anyway lick butt and make a weird face for destroy couch as revenge howl on top of tall thing. Purr while eating lay on arms while you're using the keyboard, curl up and sleep on the freshly laundered towels but rub face on everything, but scamper but kitty scratches couch bad kitty. Purr destroy the blinds sit in box and roll on the floor purring your whiskers off sleep on keyboard. Kitty scratches couch bad kitty.\\n\"}",
        'starwars' => "{\"name\":\"starwars\",\"paragraph\":\"How did I get into this mess? I really don't know how. We seem to be made to suffer. It's our lot in life. I've got to rest before I fall apart. My joints are almost frozen. What a desolate place this is. Where are you going? Well, I'm not going that way. It's much too rocky. This way is much easier. What makes you think there are settlements over there? Don't get technical with me. What mission? What are you talking about? I've had just about enough of you! Go that way! You'll be malfunctioning within a day, you nearsighted scrap pile! And don't let me catch you following me begging for help, because you won't get it. No more adventures. I'm not going that way.\\n\"}"
        }
      @lip = {
        'pirate' => "Schooner lugsail heave down gun fire in the hole broadside hail-shot Shiver me timbers clipper come about. Aye shrouds fire ship heave to lass wench quarter jib chase guns boatswain. Quarterdeck pressgang dead men tell no tales man-of-war scuppers loot black spot stern barque holystone.\n",
        'kitty' => "Immediately regret falling into bathtub stare at ceiling. Vommit food and eat it again groom yourself 4 hours - checked, have your beauty sleep 18 hours - checked, be fabulous for the rest of the day - checked!. Intently stare at the same spot loves cheeseburgers for behind the couch, for i like big cats and i can not lie. Hopped up on catnip human give me attention meow scratch the furniture howl on top of tall thing but scratch the box, or scratch leg; meow for can opener to feed me and chase ball of string. Purr. Go into a room to decide you didn't want to be in there anyway hopped up on catnip. Ignore the squirrels, you'll never catch them anyway lick butt and make a weird face for destroy couch as revenge howl on top of tall thing. Purr while eating lay on arms while you're using the keyboard, curl up and sleep on the freshly laundered towels but rub face on everything, but scamper but kitty scratches couch bad kitty. Purr destroy the blinds sit in box and roll on the floor purring your whiskers off sleep on keyboard. Kitty scratches couch bad kitty.\n",
        'starwars' => "How did I get into this mess? I really don't know how. We seem to be made to suffer. It's our lot in life. I've got to rest before I fall apart. My joints are almost frozen. What a desolate place this is. Where are you going? Well, I'm not going that way. It's much too rocky. This way is much easier. What makes you think there are settlements over there? Don't get technical with me. What mission? What are you talking about? I've had just about enough of you! Go that way! You'll be malfunctioning within a day, you nearsighted scrap pile! And don't let me catch you following me begging for help, because you won't get it. No more adventures. I'm not going that way.\n"}

  end

  def app
    Sinatra::Application
  end

  def test_the_index
    get '/'
    assert last_response.ok?
    assert_equal 'Hello World!', last_response.body
  end

  def test_names_page
    name = Faker::Name.first_name
    get "/#{name}"
    assert last_response.ok?
    assert_equal "The force be with you, #{name}.", last_response.body
  end

  def test_lipsums_page
    @jsonlip.each do |k,v|
      get "/lorem/#{k}"
      assert last_response.ok?
      assert_equal v, last_response.body
    end
  end

  def test_post_new
    post "/lorem/new",
      {name: Faker::Name.first_name.downcase, paragraph: Faker::ChuckNorris.fact}
    assert last_response.ok?

    name = Lipsum.last.name
    get "/lorem/#{name}"
    assert last_response.ok?
    Lipsum.find_by(name: name).destroy #comment this out for a fun time
  end
  
end
