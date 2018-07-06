require "myhtml"

abstract class HTML2Lucky::Tag
  abstract def print_io(io : IO) : IO
end
