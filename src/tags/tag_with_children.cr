require "myhtml"

class HTML2Lucky::TagWithChildren < HTML2Lucky::Tag
  def initialize(@node : Myhtml::Node, @depth : Int32)
  end

  def print_io(io)
    io
  end
end
