require 'sinatra'
require 'gmail'
require 'twilio-ruby'
require 'bundler'

Bundler.require

configure :development do   
  set :bind, '0.0.0.0'   
  set :port, 3000
end

Twilio.configure do |config|
  config.account_sid = 'AC881f1d62823ef5127e2b2a7a1afa30f1'
  config.auth_token = 'd743a50ba1688eba1cdba47a4eb63e51'
end

get '/' do  
end

get '/receive' do
  @client = Twilio::REST::Client.new
  puts params[:Body]
  message = params[:Body].split(' ')
  if message.length == 3
    username = message[0]
    password = message[1]
    command = message[2]

    gmail = Gmail.new(username, password)
    if command.eql? 'count'
      puts gmail.inbox.count(:unread)
      @client.messages.create(
        from: '+19284332264',
        to: params[:From],
        body: gmail.inbox.count(:unread)
      )
    elsif command.eql? 'latest'
      gmail.peek = true
      puts gmail.inbox.emails(:unread, :after => Date.today.prev_day)[0].body
      @client.messages.create(
        from: '+19284332264',
        to: params[:From],
        body: "Hi Canaan, I know it's Friday, so I'll try to keep it short. In the past few weeks we were working on a new update, which is now a vailable on the AppStore. This version has ma ny improvements including a faster way to add tasks and notes right from the list, enhanced design, faster performance and support for iPhone 6 and 6 Plus. If you are enjoying 24me, it would be great if you could please leave a review. And as always I'd be happy for any feedback."
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