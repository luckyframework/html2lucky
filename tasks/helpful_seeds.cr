require "../spec/support/boxes/**"

class Db::HelpfulSeeds < LuckyCli::Task
  banner "Add sample database records helpful for development"

  def call
    # Using a LuckyRecord::Box:
    #
    # Use the defaults, but override just the email
    # UserBox.create &.email("me@example.com")

    # Using a form:
    #
    # UserForm.create!(email: "me@example.com", name: "Jane")
    puts "Done adding sample data"
  end
end
