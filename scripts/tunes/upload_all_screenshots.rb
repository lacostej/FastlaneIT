module FastlaneIT
  module Tunes
    class UploadAllScreenshots < UploadScreenshots
      def perform
        upload_from("fixtures/screenshots_4_6_5")
      end
    end
  end
end