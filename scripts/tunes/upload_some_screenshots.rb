module FastlaneIT
  module Tunes
    class UploadSomeScreenshots < UploadScreenshots
      def perform
        upload_from("fixtures/ios/screenshots_1_6_5")
      end
    end
  end
end