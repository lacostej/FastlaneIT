module FastlaneIT
	module Tunes
		class RemoveScreenshots
			def perform
				puts "RemoveScreenshots"
				bundle_id = ENV['BUNDLE_ID']
				app = Spaceship::Tunes::Application.find bundle_id

				appv = app.edit_version

				puts "Found #{appv.screenshots.values.flatten.count} screenshots to delete"
				languages = appv.languages.map{|l| l['language']}

				languages.each {|l|
					appv.screenshots[l].each { |s|
						puts "Deleting #{l} #{s.device_type} # #{s.sort_order}"
						appv.upload_screenshot!(nil, s.sort_order, l, s.device_type)
					}
				}
				appv.save!
			end
		end
	end
end

