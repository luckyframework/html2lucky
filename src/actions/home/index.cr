class Home::Index < BrowserAction
  get "/" do
    html Home::IndexPage, output: "", input: ""
  end
end
