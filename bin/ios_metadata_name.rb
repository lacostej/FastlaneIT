
if ARGV.count == 0
  Dir.glob('fixtures/ios/metadata*/*/name.txt').each do |f|
    name = File.read(f)
    puts "#{f}: #{name}"
  end
else
  name=ARGV[0]
  Dir.glob('fixtures/ios/metadata*/*/name.txt').each do |f|
    File.write(f, name)
    puts "#{f}: #{name}"
  end
end