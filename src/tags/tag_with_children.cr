require "myhtml"

class HTML2Lucky::TagWithChildren < HTML2Lucky::Tag
  def print_io(io)
    p! method_call_with_attributes(oneliner: false)
    io << padding
    io << method_call_with_attributes(oneliner: false)
    io << " do\n"
    children_tags = tag.children.to_a
    children_tags.shift if empty_text_tag?(children_tags.first)
    children_tags.pop if empty_text_tag?(children_tags.last)
    children_tags.each do |child_tag|
      TagFactory.new(child_tag, depth + 1).build.print_io(io)
    end
    io << padding + "end"
    io << "\n"
  end
end
