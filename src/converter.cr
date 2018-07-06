require "myhtml"
require "./tag"

class HTML2Lucky::Converter
  getter output = IO::Memory.new

  def initialize(@input : String)
  end

  def convert
    html = Myhtml::Parser.new(@input)
    body = html.body!
    body.children.map do |child_tag|
      convert_tag(child_tag)
    end.join("\n")
  end

  def convert_tag(tag, depth = 0) : String
    Tag.new(node: tag, depth: depth).print_to(output)
    output.to_s
  end
end
