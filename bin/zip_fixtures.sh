if [ ! -f bin/genimages_itc.rb ]; then
  echo "Not in the right directory"
  exit -1
fi
rm -rf fixtures FastlaneIT_fixtures.zip
ruby bin/genimages_itc.rb fixtures/ios
ruby bin/genimages_play.rb fixtures/android
ruby bin/genmetadata_itc.rb fixtures/ios
ruby bin/genmetadata_play.rb fixtures/android

zip -r FastlaneIT_fixtures.zip fixtures