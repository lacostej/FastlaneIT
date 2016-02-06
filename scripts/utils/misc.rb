def pretty_time(sec)
  sec = sec.to_i
  hours = sec / 3600
  sec -= hours * 3600
  min = sec / 60
  sec -= min * 60
  time = ""
  time += "#{hours} hour(s)" if hours > 0
  time += " #{min} min(s)" if min > 0
  time += " #{sec} sec(s)"
  time.strip
end

def monitor_time
  t1=Time.new
  begin
    yield
  ensure
    t2 = Time.new
    Helper.log.info "Failed / completed after #{pretty_time(t2-t1)}"
  end
end
