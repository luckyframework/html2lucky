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
        navbar
        content
        details
        render_footer
      end
    end
  end

  def page_title
    "HTML2Lucky - Convert plain HTML into Lucky Syntax"
  end

  def navbar
    div class: "navbar-wrapper bg-light" do
      div class: "container navbar-container" do
        nav class: "navbar navbar-light" do
          span class: "navbar-brand mb-0 h1" do
            text "HTML2Lucky"
            text " "
            span class: "badge badge-success" do
              text "BETA"
            end
          end
        end
      end
    end
  end

  def details
    div class: "container" do
      para "What are the benefits of Lucky syntax over plain HTML?"
      para "Here's what Lucky's website has to say:"
      para class: "quote" do
        text "Lucky uses Crystal classes and methods to generate HTML. It may sound crazy at first, but the advantages are numerous. Never accidentally print nil to the page, extract and share partials using regular methods. Easily read an entire page by looking at just the render method. Text is automatically escaped for security. And it’s all type safe. That means no more unmatched closing tags, and never rendering a page with missing data."
      end
    end
  end

  def render_footer
    footer class: "container" do
      link "GitHub", "https://github.com/yjukaku/html2lucky"
      link "Report a bug", "https://github.com/yjukaku/html2lucky/issues/new"
      link "What is Lucky?", "https://luckyframework.org"
    end
  end
end
