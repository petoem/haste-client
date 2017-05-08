require "./spec_helper"
require "http/client"

describe "Haste" do
  it "Upload" do
    uploader = Haste::Uploader.new ENV["HASTE_SERVER"]?
    key = uploader.upload_raw "haste-client upload test."
    puts "Got key #{key}."
  end
  it "Upload should eq" do
    uploader = Haste::Uploader.new ENV["HASTE_SERVER"]?
    key = uploader.upload_raw "haste-client upload test."
    response = HTTP::Client.get URI.parse("https://hastebin.com/raw/#{key}")
    response.body.should eq("haste-client upload test.")
  end
end
