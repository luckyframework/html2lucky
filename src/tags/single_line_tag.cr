require "myhtml"

class HTML2Lucky::SingleLineTag < HTML2Lucky::Tag
  def print_io(io)
    io << padding + method_name.to_s + " "
    io << wrap_quotes(squish(tag.children.first.tag_text))
    io << ", " + attr_parameters.join(", ") if attr_parameters.any?
  end
end
