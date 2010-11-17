# Plugin to make Wes throw out snarky comments
class SnipePlugin < Campfire::PollingBot::Plugin
  accepts :text_message
  priority -2

  def process(message)
    person = message.person
    unless person == bot.name
      case message.body
      when /hate couchdb/i
        sayings = ["But #{person}, CouchDB is web scale.",
                   "#{person}, clearly you're doing it wrong. CouchDB doesn't do that",
                   "#{person}, have you considered using /dev/null?"]
        bot.say_random(sayings)
      when /(.* makes? me (sad|feel bad))/
        puts "yay"
        bot.say("#{$1}, too")
      end
    end
  end
end
