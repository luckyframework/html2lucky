require "./server"

Lucky::Session.configure do |settings| |settings|
  settings.key = "_html2lucky_session"
end

Lucky::CookieJar.configure do |settings| |settings|
  settings.on_set = ->(cookie : HTTP::Cookie) {
    # If ForceSSLHandler is enabled, only send cookies over HTTPS
    cookie.secure(Lucky::ForceSSLHandler.settings.enabled)
  # You can set other defaults for cookies here. For example:
  #
  #    cookie.expires(1.year.from_now).domain("mydomain.com")
  }
end
