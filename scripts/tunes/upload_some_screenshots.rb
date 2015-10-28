module FastlaneIT
  module Tunes
    class UploadSomeScreenshots < UploadScreenshots
      def perform
        upload_from("fixtures/screenshots_1_6_5")
      end
    end
  end
end