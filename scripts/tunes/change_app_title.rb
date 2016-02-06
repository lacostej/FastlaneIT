module FastlaneIT
  module Tunes
    class ChangeAppTitle
      def perform
        puts "ChangeAppTitle"
        bundle_id = ENV['ITC_BUNDLE_ID']
        app = Spaceship::Tunes::Application.find bundle_id

        if app.nil?
          Helper.log.error "Couldn't find app with bundle_id #{bundle_id}"
          exit -1
        end

        details = app.details

        first = details.languages.first
        title = first['name']['value'] || "WWTK Test 001"
        title = title.split(" - ")[0]
        title = "#{title} - #{Time.now.to_i}"
        first['name']['value'] = title

        details.save!

        Helper.log.info "Modified #{first['localeCode']} title to #{title}"
      end
    end
  end
end

