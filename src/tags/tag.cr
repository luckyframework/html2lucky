require "myhtml"

abstract class HTML2Lucky::Tag
  TEXT_TAG_NAME = "-text"

  getter depth

  def initialize(@node : Myhtml::Node, @depth : Int32)
  end

  private def tag
    @node
  end

  abstract def print_io(io : IO) : IO

  def padding
    " " * (depth * 2)
  end

  def no_children?(tag)
    tag.children.to_a.empty?
  end

  def single_line_tag?(tag)
    return false if tag.children.to_a.size != 1
    child_tag = tag.children.to_a.first
    return false unless text_tag?(child_tag)
    return true if child_tag.tag_text == ""
    return true if child_tag.tag_text =~ /\A\s*\Z/
    return false if child_tag.tag_text =~ /\n/
    true
  end

  def method_for(tag_name : String)
    if renamed_tag_method = Lucky::BaseTags::RENAMED_TAGS.to_h.invert[tag_name]?
      renamed_tag_method
    elsif tag_name == TEXT_TAG_NAME
      "text"
    else
      tag_name
    end
  end

  def method_name
    method_for(tag.tag_name)
  end

  def method_call_with_attributes : String
    output = method_name.to_s
    if attr_parameters.any?
      output = output + " " + attr_parameters.join(", ")
    end
    output
  end

  def attr_parameters
    convert_attributes_to_parameters.sort_by do |string|
      string.gsub(/\"/, "")
    end
  end

  def convert_attributes_to_parameters
    tag.attributes.map do |key, value|
      if Symbol.needs_quotes?(key)
        key = "\"#{key}\""
      end
      "#{key}: \"#{value}\""
    end
  end

  def text_tag?(tag)
    tag.tag_name == TEXT_TAG_NAME
  end

  def empty_text_tag?(tag)
    return false unless text_tag?(tag)
    tag.tag_text =~ /\A\s*\Z/
  end

  def output_for_text_tag : String
    text = squish(tag.tag_text)
    lines = text.split("\n").select { |line| line !~ /\A\s+\Z/ }
    lines.map_with_index do |line, i|
      line + " " unless i == lines.size - 1
      line = wrap_quotes(line)
      padding + "text #{line}"
    end.join("\n")
  end

  private def has_content? : Bool
    text = squish(tag.tag_text)
    !(text =~ /\A\s+\Z/)
  end

  def squish(string : String)
    squished = string.gsub(/(\s)\s+/) do |str, match|
      " "
    end
    squished
      .gsub(/\A\s+/, " ")
      .gsub(/\s+\Z/, " ")
  end

  def wrap_quotes(string : String) : String
    "\"#{string}\""
  end
end
