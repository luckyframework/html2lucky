abstract class MainLayout
  include Lucky::HTMLPage
  include Shared::FieldErrorsComponent
  include Shared::FlashComponent

  # You can put things here that all pages need
  #
  # Example:
  #   needs current_user : User

  abstract def content

  def render
    html_doctype

    html lang: "en" do
      head do
        utf8_charset
        title page_title
        css_link asset("css/app.css")
        js_link asset("js/app.js")
        css_link "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        csrf_meta_tags
        responsive_meta_tag
      end

      body do
        render_flash
        nav class: "navbar navbar-light bg-light" do
          span class: "navbar-brand mb-0 h1" do
            text "HTML2Lucky"
            text " "
            span class: "badge badge-success" do
              text "BETA"
            end
          end
        end
        content
      end
    end
  end

  def page_title
    "Welcome to Lucky"
  end
end
