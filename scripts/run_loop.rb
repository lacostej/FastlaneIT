require 'dotenv'
Dotenv.load('fastlane/.env')

['base', 'tunes'].each do |dir|
  Dir["./scripts/#{dir}/*.rb"].each do |path|
    require path
  end
end

FastlaneIT::Tunes::Login.new.perform
FastlaneIT::Tunes::RemoveScreenshots.new.perform
(1..10).each {
  #FastlaneIT::Tunes::UploadScreenshots.new.upload_from "fixtures/screenshots_1_1_1"
  FastlaneIT::Tunes::UploadSomeScreenshots.new.perform
}
