require "myhtml"

class HTML2Lucky::TagWithoutChildren < HTML2Lucky::Tag
  def print_io(io)
    io
    io << "\n"
  end
end
