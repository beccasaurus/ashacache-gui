require 'optparse'
require 'simplecli'

class Ashacache::Bin
  include SimpleCLI

  def usage *args
    puts <<doco

  ashacache == %{ Command Line Interface for Ashacache.com }

    Usage:
      ashacache -h/--help      [Not Implemented Yet]
      ashacache -v/--version   [Not Implemented Yet]
      ashacache command [options]

    Further help:
      ashacache commands         # list all available commands
      ashacache help <COMMAND>   # show help for COMMAND
      ashacache help             # show this help message

doco
  end 

  def chunkybacon_help
    <<doco
Usage: #{ script_name } chunkybacon

  Summary:
    Something to do with Cartoon Foxes
doco
  end
  def chunkybacon *args
    puts "Chunky Bacon!!! #{args.inspect}"
  end

end
