require "myhtml"

class HTML2Lucky::TagWithoutChildren < HTML2Lucky::Tag
  def print_io(io)
    io << padding
    io << method_name
    if attr_parameters.any?
      io << "," if custom_tag?
      io << " "
      io << attr_text
    end
    io << "\n"
  end
end
