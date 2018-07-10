require "myhtml"

class HTML2Lucky::TagWithChildren < HTML2Lucky::Tag
  BLOCK_START = " do\n"
  BLOCK_END = "end\n"

  def print_io(io)
    io << padding
    io << method_name
    if attr_parameters.any?
      io << method_joiner
      io << attr_text
    end

    io << BLOCK_START
    tag.children.each do |child_tag|
      TagFactory.new(child_tag, depth + 1).build.print_io(io)
    end
    io << padding + BLOCK_END
  end
end
