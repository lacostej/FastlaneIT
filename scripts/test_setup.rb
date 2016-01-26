require 'dotenv'
Dotenv.load('fastlane/.env')
require 'spaceship'
require 'fastlane_core'
Helper = FastlaneCore::Helper

['base', 'tunes'].each do |dir|
  Dir["./scripts/#{dir}/*.rb"].each do |path|
    puts path
    require path
  end
end

FastlaneIT::Tunes::Login.new.perform
FastlaneIT::Tunes::FindApp.new.perform
