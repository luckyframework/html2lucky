class AppServer < Lucky::BaseAppServer
  private getter server

  def middleware : Array(HTTP::Handler)
    [
      Lucky::HttpMethodOverrideHandler.new,
      Lucky::LogHandler.new,
      Lucky::SessionHandler.new,
      Lucky::FlashHandler.new,
      Lucky::ErrorHandler.new(action: Errors::Show),
      Lucky::RouteHandler.new,
      Lucky::StaticCompressionHandler.new("./public", file_ext: "gz", content_encoding: "gzip"),
      Lucky::StaticFileHandler.new("./public", false),
      Lucky::RouteNotFoundHandler.new,
    ] of HTTP::Handler
  end
end
