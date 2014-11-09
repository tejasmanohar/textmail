require 'sinatra'
require 'gmail-ruby'
require 'twilio-ruby'
require 'bundler'

Bundler.require

configure :development do   
  set :bind, '0.0.0.0'   
  set :port, 3000
end

get '/' do  
end

get '/receive' do
  puts params[:Body]
  message = params[:Body].split(' ')
  if message.length == 3
    username = message[0]
    password = message[1]
    command = message[2]

    gmail = Gmail.new(username, password)
    if command.eql? 'count'
      @client.messages.create(
        from: '+19284332264',
        to: params[:From],
        body: gmail.inbox.count(:unread)
      )
    elsif command.eql? 'latest'
      gmail.peek = true
      gmail.inbox.emails(:unread, :after => Date.today.prev_day)
    end
  else
    @client.messages.create(
      from: '+19284332264',
      to: params[:From],
      body: 'Invalid request'
    )
  end
end