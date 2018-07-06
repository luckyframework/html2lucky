require "myhtml"

class HTML2Lucky::SingleLineTag < HTML2Lucky::Tag
  def print_io(io)
    io << padding
    io << method_call_with_attributes do |html|
      html += ", "
      html += wrap_quotes(squish(tag.children.first.tag_text))
    end
    io << "\n"
  end
end
