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
    children_tags = tag.children.to_a
    children_tags.shift if empty_text_tag?(children_tags.first)
    children_tags.pop if empty_text_tag?(children_tags.last)
    children_tags.each do |child_tag|
      TagFactory.new(child_tag, depth + 1).build.print_io(io)
    end
    io << padding + BLOCK_END
  end
end
