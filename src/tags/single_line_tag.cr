require "myhtml"

class HTML2Lucky::SingleLineTag < HTML2Lucky::Tag
  def print_io(io)
    @content = wrap_quotes(squish(tag.children.first.tag_text))
    @attributes = attr_parameters.join(", ")
    io << padding
    io << method_for
    io << "," if custom_tag?
    io << " "
    io << [content, attributes].reject { |x| x.empty? }.join(", ")
    io << "\n"
  end
end
