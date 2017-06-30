require "option_parser"

module Haste
  class CLI
    def initialize
      @uploader = Uploader.new ENV["HASTE_SERVER"]?
      @raw = false
    end

    def start
      OptionParser.parse! do |parser|
        parser.banner = "Usage: haste [filename] [arguments]"
        parser.on("-r", "--raw", "Prints URL to plain/text file") { @raw = true }
        parser.on("-v", "--version", "Print haste-client version") do
          puts VERSION
          exit
        end
        parser.on("-h", "--help", "Show this help") do
          puts parser
          exit
        end
        parser.unknown_args { |unknown_args| @uploader.upload_path unknown_args[0] unless unknown_args.empty? }
      end
      unless STDIN.tty?
        @uploader.upload_raw STDIN.gets_to_end
      end
      if @raw
        url = "#{@uploader.server_url}/raw/#{@uploader.key}"
      else
        url = "#{@uploader.server_url}/#{@uploader.key}"
      end
      if STDOUT.tty?
        STDOUT.puts url
      else
        STDOUT.print url
      end
    rescue e : Exception
      abort e.message
    end
  end
end
