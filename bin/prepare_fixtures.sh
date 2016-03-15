if [ ! -f FastlaneIT_fixtures.zip ]; then
  echo "Not in the right directory"
  exit -1
fi
unzip -o FastlaneIT_fixtures.zip
cp -a fixtures/android/screenshots_4_5_5/* fixtures/android/metadata_4/

cp -a find fixtures/ios/screenshots_4_6_5/ find fixtures/ios/screenshots_4_6_1/
find fixtures/ios/screenshots_4_6_1/ -name "*_[2-5]*.jpg" | xargs rm

cp -a find fixtures/ios/screenshots_4_6_1/ find fixtures/ios/screenshots_4_6_0/
find fixtures/ios/screenshots_4_6_0/ -name "*.jpg" | xargs rm

cp -a find fixtures/ios/screenshots_4_6_5/ find fixtures/ios/screenshots_4_6_3/
find fixtures/ios/screenshots_4_6_b/ -name "*_[3-4].jpg" | xargs rm