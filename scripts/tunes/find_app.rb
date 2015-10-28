require 'fastlane_core/helper'
Helper = FastlaneCore::Helper

module FastlaneIT
  module Tunes
    class FindApp
      def perform
        puts "FindApp"
        bundle_id = ENV['BUNDLE_ID']
        app = Spaceship::Tunes::Application.find bundle_id

        if app.nil?
          Helper.log.error "Couldn't find app with bundle_id #{bundle_id}"
          exit -1
        end

        appv = app.edit_version

        Helper.log.info "Found App #{appv.application.bundle_id}"
      end
    end
  end
end

