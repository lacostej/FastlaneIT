require 'dotenv'
Dotenv.load('fastlane/.env')

['base', 'tunes'].each do |dir|
  Dir["./scripts/#{dir}/*.rb"].each do |path|
    require path
  end
end

FastlaneIT::Tunes::Login.new.perform
FastlaneIT::Tunes::FindApp.new.perform
