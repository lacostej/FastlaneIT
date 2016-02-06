require './scripts/setup.rb'

def stress_test_itc
  FastlaneIT::Tunes::Login.new.perform
  FastlaneIT::Tunes::FindApp.new.perform
  FastlaneIT::Tunes::RemoveScreenshots.new.perform
  (1..1000).each { |i|
    Helper.log.info "Loop #{i}"
    FastlaneIT::Tunes::RemoveScreenshots.new.perform
    #FastlaneIT::Tunes::FindApp.new.perform
    FastlaneIT::Tunes::ChangeAppTitle.new.perform
    FastlaneIT::Tunes::ChangeIcon.new.perform
    #FastlaneIT::Tunes::UploadScreenshots.new.upload_from "fixtures/ios/screenshots_1_1_1"
    FastlaneIT::Tunes::UploadSomeScreenshots.new.perform
  }
end

monitor_time do
  stress_test_itc
end
