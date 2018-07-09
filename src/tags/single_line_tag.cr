require "myhtml"

class HTML2Lucky::SingleLineTag < HTML2Lucky::Tag
  def print_io(io)
    content = wrap_quotes(squish(tag.children.first.tag_text))
    io << padding
    io << method_name
    io << "," if custom_tag?
    io << " "
    io << [content, attr_text].reject { |x| x.empty? }.join(", ")
    io << "\n"
  end
end
