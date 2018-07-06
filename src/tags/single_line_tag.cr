require "myhtml"

class HTML2Lucky::SingleLineTag < HTML2Lucky::Tag
  def print_io(io)
    io
  end
end
