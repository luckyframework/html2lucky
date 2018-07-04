require "../spec/support/boxes/**"

class Db::RequiredSeeds < LuckyCli::Task
  banner "Add database records required for the app to work"

  def call
    # Using a LuckyRecord::Box:
    #
    # Use the defaults, but override just the email
    # UserBox.create &.email("me@example.com")

    # Using a form:
    #
    # UserForm.create!(email: "me@example.com", name: "Jane")
    #
    # You likely want to be able to run this file more than once. To do that,
    # only create the record if it doesn't exist yet:
    #
    # unless UserQuery.new.email("me@example.com").first?
    #  # create the user
    # end
    puts "Done adding required data"
  end
end
