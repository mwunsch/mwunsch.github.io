require 'jekyll'
require 'net/smtp'
require 'netrc'
require 'pp'

class EmailNewsletter < Jekyll::Generator
  SMTP_SERVER = "mail.messagingengine.com"
  NETRC_PATH = File.expand_path("~/.authinfo")

  def generate(site)
    netrc = Netrc.read(NETRC_PATH)[SMTP_SERVER]
    if netrc.nil?
      warn("Missing credentials for #{SMTP_SERVER} in #{NETRC_PATH}. Will not attempt to email newsletter.")
      return nil
    end
    user, pass = netrc
    smtp = Net::SMTP.new("mail.messagingengine.com", 465)
    smtp.enable_tls
    letters = site.categories["tinyletter"]
    letters.select(&:published?).each do |post|
      smtp.start("markwunsch.com", user, pass, :plain) do |mail|
        # This is the scaffolding for determining how to send an email over
        # smtp in a similar fashion to publishing to tumblr.
        # We select all the non-published letters. Similarly to the tumblr_id
        # field, we identify published letters by having a message_id.
        # We generate message_ids, email them, and abort on successful sends.
        # Easy peasy.
      end
    end
  end
end
