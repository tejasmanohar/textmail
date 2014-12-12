textmail.me
===========

view and send email via sms

Setup
=====
__Shell #1__

```
git clone https://github.com/tejas-manohar/textmail
bundle
export ACCOUNT_SID = # your Twilio API key
export AUTH_TOKEN = # your Twilio auth token
ruby app.rb
```

__Shell #2__

`ngrok 4567`

__Twilio__

Enter __ngrok public tunnel__ + */receive* as *HTTP GET* request URL.
![Twilio Screenshot](https://raw.githubusercontent.com/tejas-manohar/textmail/master/screenshots/1.png)