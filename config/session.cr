require "./server"

Lucky::Session::Store.configure do
  settings.key = "html2lucky"
  settings.secret = Lucky::Server.settings.secret_key_base
end
