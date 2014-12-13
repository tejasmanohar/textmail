require 'sinatra'
require 'gmail'
require 'twilio-ruby'

configure :development do
  require 'sinatra/reloader'
end

Twilio.configure do |config|
  config.account_sid = ENV['ACCOUNT_SID']
  config.auth_token = ENV['AUTH_TOKEN']
end

get '/receive' do
  @client = Twilio::REST::Client.new
  message = params[:Body].split(' ')
  if message.length == 3
    username = message[0]
    password = message[1]
    command = message[2]

    gmail = Gmail.new(username, password)
    if command.eql? 'count'
      @client.messages.create(
        from: ENV['MY_NUMBER'],
        to: params[:From],
        body: gmail.inbox.count(:unread)
      )
    elsif command.eql? 'latest'
      gmail.peek = true
      @client.messages.create(
        from: ENV['MY_NUMBER'],
        to: params[:From],
        body: gmail.inbox.emails(:unread, :after => Date.today.prev_day)[0].message
      )
    end
  else
    @client.messages.create(
      from: '+19284332264',
      to: params[:From],
      body: 'Invalid request'
    )
  end
end
