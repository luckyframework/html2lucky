require "./spec_helper"
require "../src/converter"

describe HTML2Lucky::Converter do
  it "converts basic html" do
    input = "<div><p>Before Link<a>Link</a> After Link</p></div>"
    expected_output = <<-CODE
    div do
      para do
        text "Before Link"
        a "Link"
        text " After Link"
      end
    end
    CODE

    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "uses block syntax when inner text has new lines" do
    input = "<div class='some-class'>First Line\nSecond Line</div>"
    expected_output = <<-CODE
    div class: "some-class" do
      text "First Line "
      text "Second Line"
    end
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "handles empty tags properly" do
    input = "<div></div>"
    expected_output = <<-CODE
    div ""
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "includes simple attributes" do
    input = "<div class='some-class'>Hello</div>"
    expected_output = <<-CODE
    div "Hello", class: "some-class"
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "includes multiple attributes" do
    input = "<div class='some-class-1 some-class-2' id='abc'>Hello</div>"
    expected_output = <<-CODE
    div "Hello", class: "some-class-1 some-class-2", id: "abc"
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "includes attributes that need quoting" do
    input = "<div class='some-class-1' data-id='123'>Hello</div>"
    expected_output = <<-CODE
    div "Hello", class: "some-class-1", "data-id": "123"
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "converts multiple empty spaces into just one space" do
    input = "<div>  \n\n  </div>"
    expected_output = <<-CODE
    div " "
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "converts a tag with just new lines into a space" do
    input = "<div>\n</div>"
    expected_output = <<-CODE
    div " "
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "converts just a tag with attributes and new lines into a tag with attributes and a space" do
    input = "<div class='some-class'>\n</div>"
    expected_output = <<-CODE
    div " ", class: "some-class"
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

  it "removes leading space" do
    input = "<div> <a>Link</a></div>"
    expected_output = <<-CODE
    div do
      a "Link"
    end
    CODE
    output = HTML2Lucky::Converter.new(input).convert
    output.should eq(expected_output.strip)
  end

  it "removes trailing space" do
    input = "<div><a>Link</a> </div>"
    expected_output = <<-CODE
    div do
      a "Link"
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

  it "converts new lines inside of text into multiple text calls" do
    input = "<div>First\nSecond\nThird</div>"
    expected_output = <<-CODE
    div do
      text "First "
      text "Second "
      text "Third"
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
