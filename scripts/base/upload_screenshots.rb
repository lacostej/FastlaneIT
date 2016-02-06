module FastlaneIT
  module Tunes
    class Screenshot
      attr_accessor :device_type
      attr_accessor :language
      attr_accessor :path
      attr_accessor :sort_order
    end

    class UploadScreenshots
      def upload_from(fixtures_dir)

        appv = get_appversion(fixtures_dir)

        Helper.log.info "Found #{appv.screenshots.values.flatten.count} screenshots before upload"

        languages = appv.languages.map{|l| l['language']}
        if languages[0] != "en-US"
          Helper.log.error("First language isn't en-US but #{languages[0]}")
        end
        screenshots = find_screenshots(fixtures_dir, languages)
        Helper.log.info "Found #{screenshots.count} screenshots to upload"

        screenshots.each { |s|
          Helper.log.info "Uploading #{s.sort_order} #{s.device_type} #{s.path}"
          appv.upload_screenshot!(s.path, s.sort_order, s.language, s.device_type)
        }
        save appv
      end

      def get_appversion(fixtures_dir)
        bundle_id = ENV['ITC_BUNDLE_ID']
        Helper.log.info "UploadScreenshots #{fixtures_dir} into #{bundle_id}"

        app = Spaceship::Tunes::Application.find bundle_id

        appv = app.edit_version
      end

      def save(appv)
        Helper.log.info "Saving..."
        appv.save!
      end

      # here we don't have access to deliver information
      # so we extract the data from the file name
      def find_screenshots(fixtures_dir, languages)
        screenshots = []
        languages.each {|language| 
          Dir.glob("#{fixtures_dir}/#{language}/*.jpg").each { |path|
            file = File.basename path
            m = file.match(/screenshot_(.*)_(.*)_(.*).jpg/)

            s = Screenshot.new

            s.device_type = m[1]
            s.language = language
            s.sort_order = m[3].to_i
            s.path = path

            screenshots << s
          }
        }
        screenshots
      end
    end
  end
end