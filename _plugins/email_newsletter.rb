require 'jekyll'
require 'net/smtp'
require 'netrc'
require 'securerandom'
require 'time'
require 'pp'

class EmailNewsletter < Jekyll::Generator
  SMTP_SERVER = "mail.messagingengine.com"
  NETRC_PATH = File.expand_path("~/.authinfo")
  FROM = "mark@markwunsch.com"
  TINYLETTER_ADDR = ENV["TINYLETTER_ADDR"]

  def generate(site)
    netrc = Netrc.read(NETRC_PATH)[SMTP_SERVER]
    if netrc.nil?
      warn("Missing credentials for #{SMTP_SERVER} in #{NETRC_PATH}. Will not attempt to email newsletter.")
      return nil
    end
    if TINYLETTER_ADDR.nil?
      warn("Missing TinyLetter Address in ENV. Will not attempt to send mail.")
      return nil
    end
    user, pass = netrc
    smtp = Net::SMTP.new("mail.messagingengine.com", 465)
    smtp.enable_tls
    mailed = []

    letters = site.categories["tinyletter"]
    letters.select(&:published?).reject {|p| p.data.key?("message_id") }.each do |post|
      post.data["message_id"] = message_id
      to_addr = post.is_a?(Jekyll::Draft) ? "mark+tinyletter-draft@markwunsch.com" : TINYLETTER_ADDR
      response = smtp.start("markwunsch.com", user, pass, :plain) do |mail|
        mail.send_message msgstr(post, to_addr), FROM, to_addr
      end
      if response.success?
        File.open(File.join(site.source, post.path), "w") do |file|
          file.write "#{post.data.to_yaml}---\n\n#{post.to_s}"
        end
        mailed << post
        puts "Success. Updated #{post.path} to reflect changes."
      else
        abort "Encountered an error while attempting to send mail. Aborting.\n\t#{response.message}"
      end
    end

    abort "Mailed #{mailed.count} post(s)." unless mailed.empty?
  end

  def message_id
    # As described in "Recommendations for generating Message IDs"
    # https://www.jwz.org/doc/mid.html
    local_part = [
      Time.now.to_i.to_s(36),
      SecureRandom.random_bytes(8).unpack("Q").map {|i| i.to_s(36) }.join
    ].join(".")
    "<#{local_part}@markwunsch.com>"
  end

  def msgstr(post, to_addr)
    <<EOM
From: Mark Wunsch <#{FROM}>
To: #{to_addr}
Subject: #{post.title}
Date: #{post.date.rfc2822}
Message-ID: #{post.data['message_id']}

#{post}
EOM
  end
end
