textmail.me
===========

check email via sms

limited to gmail at this time

Setup
=====
__Shell #1__

```
git clone https://github.com/tejas-manohar/textmail
bundle
export ACCOUNT_SID = # your Twilio API key
export AUTH_TOKEN = # your Twilio auth token
export MY_NUMBER = # your Twilio phone number
ruby app.rb
```

__Shell #2__

`ngrok 4567`

__Twilio__

Enter __ngrok public tunnel__ + */receive* as *HTTP GET* request URL.
![Twilio Screenshot](https://raw.githubusercontent.com/tejas-manohar/textmail/master/screenshots/1.png)

Usage
=====
Text your Twilio phone number either of the following commands:

- count
  - replies with # of unread emails
- latest
  - replies with body of latest email in inbox

Every command must be prefaced with "<youremail@gmail.com> <password>"

... for example,
g
Text +1 233 332 4557 - `bob@gmail.com cheesecake95 count`
