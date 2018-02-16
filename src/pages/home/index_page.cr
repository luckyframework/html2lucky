class Home::IndexPage < MainLayout
  needs input : String
  needs output : String

  def content
    div class: "container" do
      div class: "row" do
        div class: "col-lg" do
          h1 "Input HTML"
          form_for Home::Convert, class: "input-form" do
            textarea @input, name: "input", class: "form-control html-input", placeholder: "Paste your HTML here"
            submit "Convert!", class: "btn btn-lg btn-success"
          end
        end
        div class: "col-lg" do
          h1 "Lucky Syntax"
          pre class: "output" do
            text @output
          end
        end
      end
    end
  end
end
