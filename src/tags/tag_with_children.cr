require "myhtml"

class HTML2Lucky::TagWithChildren < HTML2Lucky::Tag
  def print_io(io)
    io << padding + method_call_with_attributes(method_name, attr_parameters, false)
    io << " do\n"
    children_tags = tag.children.to_a
    children_tags.shift if empty_text_tag?(children_tags.first)
    children_tags.pop if empty_text_tag?(children_tags.last)
    children_tags.each do |child_tag|
      TagFactory.new(child_tag, depth + 1).build.print_io(io)
    end
    io << "\n" + padding + "end"
  end
end
