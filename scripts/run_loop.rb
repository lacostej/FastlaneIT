require 'dotenv'
Dotenv.load('fastlane/.env')
require 'spaceship'
require 'fastlane_core/helper'
Helper = FastlaneCore::Helper

['base', 'tunes'].each do |dir|
  Dir["./scripts/#{dir}/*.rb"].each do |path|
    require path
  end
end

FastlaneIT::Tunes::Login.new.perform
FastlaneIT::Tunes::RemoveScreenshots.new.perform
(1..1000).each { |i|
  puts "Loop #{i}"
  #FastlaneIT::Tunes::RemoveScreenshots.new.perform
  #FastlaneIT::Tunes::FindApp.new.perform
  #FastlaneIT::Tunes::ChangeAppTitle.new.perform
  #FastlaneIT::Tunes::ChangeIcon.new.perform
  #FastlaneIT::Tunes::UploadScreenshots.new.upload_from "fixtures/screenshots_1_1_1"
  FastlaneIT::Tunes::UploadSomeScreenshots.new.perform
}
