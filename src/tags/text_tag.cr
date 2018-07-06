require "myhtml"

class HTML2Lucky::TextTag < HTML2Lucky::Tag
  def print_io(io)
    squished_text = squish(tag.tag_text)
    io << output_for_text_tag(squished_text, padding)
  end
end
