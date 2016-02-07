while [[ 1 ]]; do
  d=`date +%Y%m%d-%H%M%S`
  rm -f /tmp/spaceship*
  mkdir -p loops/$d
  ruby scripts/run_loop.rb 2>&1 | tee -a > loops/$d/output.log
  mv /tmp/spaceship* loops/$d/
done
