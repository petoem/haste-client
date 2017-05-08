module Haste
  class CLI
    # Create a new uploader
    def initialize
      @uploader = Uploader.new ENV["HASTE_SERVER"]?
    end

    # And then handle the basic usage
    def start
      # Take data in
      if STDIN.tty?
        key = @uploader.upload_path ARGV.first
      else
        key = @uploader.upload_raw STDIN.gets_to_end
      end
      # Put together a URL
      if ARGV.includes?("--raw")
        url = "#{@uploader.server_url}/raw/#{key}"
      else
        url = "#{@uploader.server_url}/#{key}"
      end
      # And write data out
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
