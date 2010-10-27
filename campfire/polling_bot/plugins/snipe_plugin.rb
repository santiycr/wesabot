# Plugin to make Wes throw out snarky comments
class SnipePlugin < Campfire::PollingBot::Plugin
  accepts :text_message
  priority -2

  def process(message)
    person = message.person
    case message.body
    when /hate couchdb/i
      sayings = ["But #{person}, CouchDB is web scale.",
                 "#{person}, clearly you're doing it wrong. CouchDB doesn't do that",
                 "#{person}, have you considered using /dev/null?"]
      bot.say_random(sayings)
    end
  when /(.*) makes me sad/
    bot.say("#{$1} makes me sad, too")
  end
end
