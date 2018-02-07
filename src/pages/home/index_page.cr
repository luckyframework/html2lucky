class Home::IndexPage < MainLayout
  needs input : String
  needs output : String

  def content
    form_for Home::Convert do
      textarea @input, name: "input"
      submit "Convert!"
    end
    text "OUTPUT"
    pre do
      text @output
    end
  end
end
