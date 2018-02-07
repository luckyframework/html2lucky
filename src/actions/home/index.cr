class Home::Index < BrowserAction
  get "/" do
    render Home::IndexPage, output: "nothing yet", input: "Put html here"
  end
end
