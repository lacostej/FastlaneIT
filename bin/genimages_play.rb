require 'fileutils'

# example API
# SG=PlayScreenshotGenerator.new(Helper.dimensions)
# path='whatever.png'
# SG.generate_image(path, [100, 120], 'FCFEE8')
# SG.add_image_caption(path, '10"tab en-US')
class PlayScreenshotGenerator
  attr_accessor :dimensions

  def initialize(dimensions)
    @dimensions = dimensions
  end

  def generate_screenshots(path, prefix, locales, device_types, colors)
    puts "Generating screenshots under #{path}"
    locales.each do |locale|
      device_types.each do |type|
        dir = "#{path}/#{locale}/images/#{type}Screenshots"
        FileUtils.mkdir_p(dir)
  
        index = 0
        resolution = @dimensions[type]
        colors.each do |color|
          r = "#{resolution[0]}x#{resolution[1]}"
          image_path = "#{dir}/#{prefix}_#{type}_#{r}_#{index + 1}.jpg"
          if File.exist? image_path
            puts "Skipping #{image_path}"
            next
          else
            puts "Generating #{image_path}"
          end
          generate_image(image_path, resolution, colors[index])
          add_image_caption(image_path, "#{type} #{locale} ##{index + 1}")

          index += 1
        end
      end
    end
  end

  def generate_image(path, resolution, color)
    r = "#{resolution[0]}x#{resolution[1]}"
    `convert -size #{r} xc:##{color} #{path}`
  end

  def add_image_caption(path, text)
    width = `identify -format %w #{path}`
    height = `identify -format %h #{path}`.to_i
    h = [30, (0.2 * height)].max
    `convert -background '#0008' -fill white -gravity center -size #{width}x#{h} caption:\" #{text} \" #{path} +swap -gravity south -composite #{path}`
    # `convert #{path} -pointsize #{pointsize} label:'#{text}' 
    # +swap -gravity Center -annotate #{path}`
  end
end

# generate screens given out test configuration
class Helper
  class << self; attr_accessor :locales, :colors, :dimensions, :sg; end

  @@locales = ['en-US', 'fr-FR', 'es-ES', 'no-NO']

  @@colors = [
    'FCFEE8',
    '6D6905',
    'C8B769',
    '36B1C0',
    'ADF4D6'
  ]

  @@dimensions = {
    'phone' => [750, 1334],
    'sevenInch' => [1242, 2208],
    'tenInch' => [1536, 2048],
    'tv' => [1920, 1080],
    'wear' => [320, 320]
  }

  @@sg = PlayScreenshotGenerator.new(@@dimensions)

  class << self
    def generate(folder, n_locales, n_types, n_screenshots)
      @@sg.generate_screenshots("#{folder}/screenshots_#{n_locales}_#{n_types}_#{n_screenshots}",
                                'screenshot',
                                @@locales[0, n_locales],
                                @@dimensions.keys[0, n_types],
                                @@colors[0, n_screenshots])
    end
  end
end
if ARGV.count == 0
  puts 'ERROR: Missing target directory argument'
  puts "USAGE: #{$PROGRAM_NAME} fixtures_dir"
  exit(-1)
end
dir = ARGV[0]
Helper.generate(dir, 1, 1, 1)
Helper.generate(dir, 1, 3, 5)
Helper.generate(dir, 4, 5, 5)
