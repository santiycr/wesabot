# Fixing the build is important. Keep track of who's doing it

require 'time'

class BuildFixingPlugin < Campfire::PollingBot::Plugin
  accepts :text_message

  def initialize
    @fixers = Set.new
  end

  def process(message)
    return if message.person == bot.name
    if message.body =~ /who('| i)s .* the build/
      if @fixers.empty?
        bot.say("Nobody is fixing the build")
      else
        @fixers.each do |fixer|
          bot.say("#{fixer} is fixing the build")
        end
      end
      return HALT
    elsif message.body =~ /([Ww]es[,:]? )?(.*)\s*fixing the build/
      command = $2
      case command
      when /I'm\s*$/
        @fixers.add(message.person.downcase)
      when /I'm done/
        @fixers.delete(message.person.downcase)
      when /I'm not/
        @fixers.delete(message.person.downcase)
      when /(.*)\s+is\s*$/
        @fixers.add($1)
      when /(.*)\s+is (not|done)/
        @fixers.delete($1)
      end
      return HALT
    end
    if message.person == "Hudson" && message.body =~ /SUCCESS/
      @fixers.clear
    end
  end

  def help
    return []
  end
end
