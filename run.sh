#DEBUG=true SPACESHIP_USER_AGENT='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36' deliver -f -w no_screenshots

# comment out if you need to experiment a bit
#XXX=DEBUG\=true
rm -f /tmp/spaceship*

#$XXX fastlane test_all
$XXX fastlane meta_upload && ruby scripts/run_all.rb