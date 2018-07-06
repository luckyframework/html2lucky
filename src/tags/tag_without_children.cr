require "myhtml"

class HTML2Lucky::TagWithoutChildren < HTML2Lucky::Tag
  def print_io(io)
    io << padding
    io << method_call_with_attributes(oneliner: true)
    io << "\n"
  end
end
