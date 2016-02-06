require './scripts/setup.rb'

FastlaneIT::Tunes::Login.new.perform
FastlaneIT::Tunes::RemoveScreenshots.new.perform
FastlaneIT::Tunes::UploadScreenshots.new.upload_from "fixtures/screenshots_1_1_1"
FastlaneIT::Tunes::UploadSomeScreenshots.new.perform
FastlaneIT::Tunes::UploadAllScreenshots.new.perform
