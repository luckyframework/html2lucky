require "./spec_helper"
require "../src/converter"

describe HTML2Lucky::Converter do
  it "converts basic html" do
    input = "<div><p>Before Link<a>Link</a> After Link</p></div>"
    expected_output = <<-CODE
    div do
      para do
        text "Before Link"
        a do
          text "Link"
        end
        text " After Link"
      end
    end
    CODE

    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "includes simple attributes" do
    input = "<div class='some-class'>Hello</div>"
    expected_output = <<-CODE
    div class: "some-class" do
      text "Hello"
    end
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "includes multiple attributes" do
    input = "<div class='some-class-1 some-class-2' data-id='123'>Hello</div>"
    expected_output = <<-CODE
    div class: "some-class-1 some-class-2", "data-id": "123" do
      text "Hello"
    end
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "converts multiple empty spaces into just one space" do
    input = "<div>  \n\n  </div>"
    expected_output = <<-CODE
    div do
      text " "
    end
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "converts just new lines into a space" do
    input = "<div>\n</div>"
    expected_output = <<-CODE
    div do
      text " "
    end
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "converts leading new lines into a space" do
    input = "<div>\nHello</div>"
    expected_output = <<-CODE
    div do
      text " Hello"
    end
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "converts trailing new lines into a space" do
    input = "<div>Hello\n</div>"
    expected_output = <<-CODE
    div do
      text "Hello "
    end
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  pending "doesn't crash on invalid input" do
    input = "<div <p>></p>"
    HTML2Lucky::Converter.new(input).convert
  end
end
