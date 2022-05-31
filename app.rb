# frozen_string_literal: true

require 'functions_framework'
require 'fjord_boot_camp'

def main
  client = FjordBootCamp::Client.new
  client.authenticate(ENV['LOGIN_NAME'], ENV['PASSWORD'])
  message = client.unchecked_reports
  puts message

  discord = FjordBootCamp::Discord.new
  discord.post(message, ENV['WEBHOOK_URL'])
end

FunctionsFramework.http 'http_unchecked_reports' do |_|
  main
  'OK'
end

FunctionsFramework.cloud_event 'unchecked_reports' do |_|
  main
end
