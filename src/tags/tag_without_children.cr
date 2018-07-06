require "myhtml"

class HTML2Lucky::TagWithoutChildren < HTML2Lucky::Tag
  def print_io(io)
    io << padding
    io << method_call_with_attributes(method_name, attr_parameters, true)
    io << "\n"
  end
end
