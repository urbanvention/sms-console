# SMS-Console
This piece of software allows you to send sms via your console.

The cool part about it is, you're able to name someone sitting in your
Addressbook.app (Mac only) to send a sms to his/her mobile phone.

The following example will
* send a message to Jan Riethmayer, who must be in your address book
* `dry-run` won't send the message, but contact the api with test credentials
* `verbose` will give you the response, the text and the mobile phone number
* `cheap` will leave the sender number empty, this sms is cheaper than providing
  your phone number so your receiver may answer.

    ./sms_console.rb -p"Jan Riethmayer" --verbose --cheap --dry-run \
    "Your Message with a maximum of 160 letters"

# Legal notice
2010 (cc) Jan Riethmayer
This work is licensend under a Creative Commons Attribution 3.0 license.
