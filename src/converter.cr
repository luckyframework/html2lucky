require "myhtml"

class HTML2Lucky::Converter
  def initialize(@input : String)
  end

  def convert
    html = Myhtml::Parser.new(@input)
    body = html.body!
    body.children.map do |child_tag|
      convert_tag(child_tag)
    end.join("\n")
  end

  def convert_tag(tag, depth = 0) : String
    method_name = method_for(tag.tag_name)
    attr_parameters = convert_attributes_to_parameters(tag.attributes).sort_by do |string|
      string.gsub(/\"/, "")
    end
    output = ""
    padding = " " * (depth * 2)
    if tag.children.to_a.empty?
      output += padding + "#{method_name} \"#{squish(tag.tag_text)}\""
      output += ", #{attr_parameters.join(", ")}" if attr_parameters.any?
    else
      output += padding + method_name.to_s
      output += " " + attr_parameters.join(", ") if attr_parameters.any?
      output += " do\n"
      children_output = tag.children.map { |child_tag| convert_tag(child_tag, depth + 1).as(String) }
      output += children_output.join("\n")
      output += "\n" + padding + "end"
    end
    output
  end

  def convert_attributes_to_parameters(attributes)
    attr_parameters = attributes.map do |key, value|
      if Symbol.needs_quotes?(key)
        key = "\"#{key}\""
      end
      "#{key}: \"#{value}\""
    end
  end

  def method_for(tag_name : String)
    if renamed_tag_method = Lucky::BaseTags::RENAMED_TAGS.to_h.invert[tag_name]?
      renamed_tag_method
    elsif tag_name == "-text"
      "text"
    else
      tag_name
    end
  end

  def squish(string : String)
    string.gsub(/(\s)\s+/) do |str, match|
      match[1]
    end
  end
end
