require 'fileutils'

class MetadataGenerator 
	def generate_metadata(one_locale, path, locales)
		puts "Generating metadata under #{path}"
		FileUtils.mkdir_p(path)
		#FileUtils.rm_r Dir.glob("#{path}/*")

		locales.each { |locale|
			dir="#{path}/#{locale}"

			puts "FileUtils.cp_r #{one_locale} #{dir}"
		}
	end
end

if ARGV.count == 0
	puts "ERROR: Missing target directory argument"
	puts "USAGE: #{$0} fixtures_dir"
	exit -1
end
dir=ARGV[0]

locales = ['en-US', 'fr-FR', 'es-ES', 'no']
MG = MetadataGenerator.new()
MG.generate_metadata("#{dir}/metadata/en-US",
	"#{dir}/metadata_#{locales.count}",
	locales)