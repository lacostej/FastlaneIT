if [ ! -f FastlaneIT_fixtures.zip ]; then
  echo "Not in the right directory"
  exit -1
fi
unzip -o FastlaneIT_fixtures.zip
cp -a fixtures/android/screenshots_4_5_5/* fixtures/android/metadata_4/