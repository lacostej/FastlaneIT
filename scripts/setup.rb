require 'dotenv'
Dotenv.load('fastlane/.env')
require 'spaceship'
require 'fastlane_core/helper'
require 'colored'
Helper = FastlaneCore::Helper

['utils', 'base', 'tunes'].each do |dir|
  Dir["./scripts/#{dir}/*.rb"].each do |path|
    require path
  end
end