require "./app"

Habitat.raise_if_missing_settings!

app = App.new

Signal::INT.trap do
  app.close
end

puts "Listening on #{app.base_uri}"
app.listen
