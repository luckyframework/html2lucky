require "myhtml"

class HTML2Lucky::TagWithoutChildren < HTML2Lucky::Tag
  def initialize(@node : Myhtml::Node)
  end

  def print_io(io)
    io
  end
end
