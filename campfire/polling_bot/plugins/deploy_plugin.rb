# Plugin to keep track of when deploys happened
class DeployPlugin < Campfire::PollingBot::Plugin
  accepts :text_message

  def process(message)
    if message.person == "Deploy"
      if message.body =~ /(.*) is deploying/
        deploy = Deploy.create(
          :who => $1,
          :timestamp => message.timestamp,
          :souschef_restarted => !!(message.body =~ /souschef/)
        )
      end
    end
    case message.command
    when /deploy/
      deploy = Deploy.last(:order => [:timestamp.asc])
      if deploy
        bot.say("#{deploy.who} deployed at #{deploy.timestamp}")
      else
        bot.say("I don't know")
      end
      return HALT
    end
  end

  def help
    return []
  end
end
