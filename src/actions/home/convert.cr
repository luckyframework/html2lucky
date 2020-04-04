require "../../converter"

class Home::Convert < BrowserAction
  param input : String = ""

  post "/convert" do
    context.response.headers["X-XSS-Protection"] = "0"
    output = HTML2Lucky::Converter.new(input).convert
    html Home::IndexPage, output: output, input: input
  end
end
