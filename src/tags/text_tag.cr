require "myhtml"

class HTML2Lucky::TextTag < HTML2Lucky::Tag
  def print_io(io)
    if has_content?
      io << output_for_text_tag
      io << "\n"
    end
  end
end
