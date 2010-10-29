# Fixing the build is important. Keep track of who's doing it

require 'time'

class BuildFixingPlugin < Campfire::PollingBot::Plugin
  accepts :text_message

  def initialize
    @fixers = Set.new
  end

  def process(message)
    if message.body =~ /(.*)\s*fixing the build/
      command = $1
      case command
      when /I'm/
        @fixers.add(message.person.downcase)
      when /I'm done/
        @fixers.delete(message.person.downcase)
      when /I'm not/
        @fixers.delete(message.person.downcase)
      when /(.*)\s+ is/
        @fixers.add($1)
      when /(.*)\s+ is not/
        @fixers.add($1)
      when /who.*/
        @fixers.each do |fixer|
          bot.say("#{fixer} is fixing the build")
        end
      end
    end
    if message.person == "buildbot" && message.body =~ /FIXED/
      @fixers.clear
    end
  end

  def help
    return []
  end
end
