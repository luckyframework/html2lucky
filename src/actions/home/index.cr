class Home::Index < BrowserAction
  get "/" do
    render Home::IndexPage, output: "", input: ""
  end
end
