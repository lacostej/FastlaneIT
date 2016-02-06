module FastlaneIT
  module Tunes
    class ChangeIcon
      def perform
        puts "ChangeIcon"
        bundle_id = ENV['ITC_BUNDLE_ID']
        app = Spaceship::Tunes::Application.find bundle_id

        if app.nil?
          Helper.log.error "Couldn't find app with bundle_id #{bundle_id}"
          exit -1
        end

        appv = app.edit_version

        appv.upload_large_icon!('fastlane/AppIcon.png')

        appv.save!

        Helper.log.info "Modified icon"
      end
    end
  end
end

