require 'fileutils'

class ScreenshotGenerator 
	attr_accessor :dimensions

  	def initialize(dimensions)
    	@dimensions = dimensions
  	end

	def generate_screenshots(path, prefix, locales, device_types, colors)
		puts "Generating screenshots under #{path}"
		locales.each { |locale|
			dir="#{path}/#{locale}"
			FileUtils.mkdir_p(dir)
			device_types.each { |type|
				index = 0
				resolution = @dimensions[type]
				colors.each {|color|
					r="#{resolution[0]}x#{resolution[1]}"
					image_path = "#{dir}/#{prefix}_#{type}_#{r}_#{index+1}.jpg"
					puts "PATH #{image_path}"

					self.generate_image(image_path, resolution, colors[index])
					self.add_image_caption(image_path, "#{type} #{locale} ##{index + 1}")

					index += 1
				}
			}
		}
	end

	def generate_image(path, resolution, color)
		r="#{resolution[0]}x#{resolution[1]}"
		`convert -size #{r} xc:##{color} #{path}`
	end

	def add_image_caption(path, text)
		width=`identify -format %w #{path}`
		height=`identify -format %h #{path}`.to_i
		h=[30, (0.2*height)].max
  		`convert -background '#0008' -fill white -gravity center -size #{width}x#{h} caption:\" #{text} \" #{path} +swap -gravity south -composite #{path}`
		#`convert #{path} -pointsize #{pointsize} label:'#{text}' +swap -gravity Center -annotate #{path}`
	end
end

class Helper
	class << self; attr_accessor :locales, :colors, :dimensions, :SG; end

	@@locales = ['en-US', 'fr-FR', 'es-ES', 'no']

	@@colors = [
		'FCFEE8',
		'6D6905',
		'C8B769',
		'36B1C0',
		'ADF4D6'
		]

	@@dimensions = {
		'watch' => [312, 390],
		'mac' => [900, 1440],
		'ipad' => [1536, 2048],
		'iphone35' => [640, 960],
		'iphone4' => [640, 1136],
		'iphone6' => [750, 1334],
		'iphone6Plus' => [1242, 2208],
		'ipadPro' => [2048, 2732]
	}

	@@SG = ScreenshotGenerator.new(@@dimensions)

	class << self
		def generate(folder, n_locales, n_types, n_screenshots)
		  @@SG.generate_screenshots("#{folder}/screenshots_#{n_locales}_#{n_types}_#{n_screenshots}", 'screenshot',
		  	@@locales[0, n_locales],
		  	@@dimensions.keys[0, n_types],
		  	@@colors[0, n_screenshots])
		end
	end
end



#SG=ScreenshotGenerator.new(Helper.dimensions)
#path='whatever.png'
#SG.generate_image(path, [100, 120], 'FCFEE8')
#SG.add_image_caption(path, 'iPad en-US')


Helper.generate("fixtures", 1, 1, 1)
Helper.generate("fixtures", 5, 5, 5)
