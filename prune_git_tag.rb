require 'Open3'

stdin, stdout, stderr = Open3.popen3('git tag')
while tag = stdout.gets
  secin, secout, secerr = Open3.popen3('git ls-remote origin refs/tags/' + tag)
  if secout.gets
    # do nothing.
  else
    system('git tag -d ' + tag)
  end
end
