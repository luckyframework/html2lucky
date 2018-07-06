require "../../converter"

class Home::Convert < BrowserAction
  param input : String = ""

  get "/convert" do
    context.response.headers["X-XSS-Protection"] = "0"
    output = HTML2Lucky::Converter.new(input).convert
    render Home::IndexPage, output: output, input: input
  end
end
