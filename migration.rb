require 'active_record'
require_relative 'lipsum'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'development.sqlite3'
)

class ApplicationMigration < ActiveRecord::Migration
  def change
    create_table "lipsums", force: true do |t|
      t.text  "name"
      t.text  "text"
    end
    load
  end

  def load
    lips= [{name: 'pirate', text: "Schooner lugsail heave down gun fire in the hole broadside hail-shot Shiver me timbers clipper come about. Aye shrouds fire ship heave to lass wench quarter jib chase guns boatswain. Quarterdeck pressgang dead men tell no tales man-of-war scuppers loot black spot stern barque holystone.\n"},
    {name: 'kitty', text: "Immediately regret falling into bathtub stare at ceiling. Vommit food and eat it again groom yourself 4 hours - checked, have your beauty sleep 18 hours - checked, be fabulous for the rest of the day - checked!. Intently stare at the same spot loves cheeseburgers for behind the couch, for i like big cats and i can not lie. Hopped up on catnip human give me attention meow scratch the furniture howl on top of tall thing but scratch the box, or scratch leg; meow for can opener to feed me and chase ball of string. Purr. Go into a room to decide you didn't want to be in there anyway hopped up on catnip. Ignore the squirrels, you'll never catch them anyway lick butt and make a weird face for destroy couch as revenge howl on top of tall thing. Purr while eating lay on arms while you're using the keyboard, curl up and sleep on the freshly laundered towels but rub face on everything, but scamper but kitty scratches couch bad kitty. Purr destroy the blinds sit in box and roll on the floor purring your whiskers off sleep on keyboard. Kitty scratches couch bad kitty.\n"},
    {name: 'starwars', text: "How did I get into this mess? I really don't know how. We seem to be made to suffer. It's our lot in life. I've got to rest before I fall apart. My joints are almost frozen. What a desolate place this is. Where are you going? Well, I'm not going that way. It's much too rocky. This way is much easier. What makes you think there are settlements over there? Don't get technical with me. What mission? What are you talking about? I've had just about enough of you! Go that way! You'll be malfunctioning within a day, you nearsighted scrap pile! And don't let me catch you following me begging for help, because you won't get it. No more adventures. I'm not going that way.\n"}
      ]
    lips.each{ |l| Lipsum.create(l)}

  end


  ApplicationMigration.migrate(:up)
end
