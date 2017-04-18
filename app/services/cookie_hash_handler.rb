require 'digest'

class CookieHashHandler
  def initialize(text, exclude)
    @text = text
    @exclude = exclude
  end

  def cookie_hash
    Digest::SHA256.hexdigest(@text.downcase.gsub(/[^a-z0-9\s]/i, '') + joined_exclude)
  end

  def valid?(client_cookie_hash)
    return true if ENV['disable_cheating_prevention']
    client_cookie_hash && client_cookie_hash == cookie_hash
  end

  private

  def joined_exclude
    @exclude.map { |e| e.downcase.gsub(/[^a-z0-9\s]/i, '') }.join("")
  end
end