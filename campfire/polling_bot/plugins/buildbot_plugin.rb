# Plugin to communicate with a buildbot server

require 'xmlrpc/client'

class BuildbotPlugin < Campfire::PollingBot::Plugin
  accepts :text_message, :addressed_to_me => true

  def process(message)
    case message.command
    when /how('| i)s the build/
      bb = XMLRPC::Client.new2(config['endpoint'])
      builds = bb.call("getLastBuilds", "buildbot-saucelabs", 11).map{|b| b[-3]}
      success = builds.count {|b| b == "success"}
      failure = builds.count {|b| b == "failure"}
      bot.say("#{failure} of the last 10 builds failed")
      if failure > success
        bot.say("Somebody should probably, y'know, fix that")
      end
      return HALT
    end
  end

  def help
    return [["How's the build?", "Find out how the build is doing"]]
  end
end
