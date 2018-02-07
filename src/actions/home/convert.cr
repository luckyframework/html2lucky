require "../../converter"

class Home::Convert < BrowserAction
  param input : String = ""

  post "/" do
    output = HTML2Lucky::Converter.new(input).convert
    render Home::IndexPage, output: output, input: input
  end
end
