require "myhtml"

class HTML2Lucky::TextTag < HTML2Lucky::Tag
  def print_io(io)
    if has_content?
      io << output_for_text_tag
      io << "\n"
    end
  end

  private def output_for_text_tag : String
    text = squish(tag.tag_text)
    line = text.tr("\n", " ")
    line = wrap_quotes(line)
    padding + "text #{line}"
  end
end
