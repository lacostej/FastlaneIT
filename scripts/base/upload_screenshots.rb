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
        bundle_id = ENV['BUNDLE_ID']
        puts "UploadScreenshots #{fixtures_dir} into #{bundle_id}"

        app = Spaceship::Tunes::Application.find bundle_id

        appv = app.edit_version

        puts "Found #{appv.screenshots.values.flatten.count} screenshots before upload"

        languages = appv.languages.map{|l| l['language']}
        screenshots = find_screenshots(fixtures_dir, languages)
        puts "Found #{screenshots.count} screenshots to upload"

        screenshots.each { |s|
          puts "Uploading #{s.sort_order} #{s.device_type} #{s.path}"
          appv.upload_screenshot!(s.path, s.sort_order, s.language, s.device_type)
        }
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