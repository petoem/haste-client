require "json"
require "http/client"

module Haste
  DEFAULT_URL = "https://hastebin.com"

  class Uploader
    getter server_url

    def initialize(server_url)
      @server_url = server_url || Haste::DEFAULT_URL
      @server_url = @server_url.dup
      @server_url = @server_url.rchop if @server_url.ends_with?('/')
    end

    # Take in a path and return a key
    def upload_path(path)
      fail_with "No input file given" unless path
      fail_with "#{path}: No such path" unless File.exists?(path)
      upload_raw File.read(path)
    end

    # Take in data and return a key
    def upload_raw(data)
      data = data.rstrip
      response = do_post data
      if response.status_code == 200
        data = JSON.parse(response.body)
        data["key"]
      else
        fail_with "failure uploading: #{response.body}"
      end
    rescue e : JSON::ParseException
      fail_with "failure parsing response: #{e.message}"
    end

    private def do_post(data)
      connection.post("/documents", body: data)
    end

    private def connection
      uri = URI.parse(server_url)
      @connection ||= HTTP::Client.new uri
    end

    private def fail_with(msg)
      raise Exception.new(msg)
    end
  end
end
