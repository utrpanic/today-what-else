require 'xcodeproj'
require 'Open3'

# TODO
project_name = ''
bitrise_trigger_url = ''

line = '###############################################'

if ARGV.length != 1
  usage_error_message = '- Usage: [ruby ' + File.basename($0) + ' new] or [ruby ' + File.basename($0) + ' rc]'
  puts usage_error_message
  exit
end

trigger_type = ARGV[0]
NEW_TYPE = 'new'
RC_TYPE = 'rc'

plist_path = './' + project_name + '/Info.plist'
plist = Xcodeproj::Plist.read_from_path(plist_path)
current_version_array = plist['CFBundleVersion'].split('.')
v1 = current_version_array[0].to_i
v2 = current_version_array[1].to_i
v3 = current_version_array[2].to_i

if trigger_type == NEW_TYPE
  puts 'Really? [yes]'
  input = STDIN.gets.chomp
  if input != 'yes'
    puts 'End'
    exit
  end
  # Remove rc tags.
  tag_prefix = "v%d.%d.%d-RC*" % [v1, v2, v3]
  puts tag_prefix
  stdin, stdout, stderr = Open3.popen3('git tag | grep ' + tag_prefix)
  while tag = stdout.gets
    system('git tag -d ' + tag)
    system('git push origin :refs/tags/' + tag)
  end

  # Version up when new
  v3 += 1
  rc = 0
  if v3 == 10
    v3 = 0
    v2 += 1
  end
  if v2 == 10
    v2 = 0
    v1 += 1
  end
  additional_commit_message = ''
elsif trigger_type == RC_TYPE
  # Version up when rc
  rc = current_version_array[3].to_i + 1
  puts 'Additional commit message: '
  additional_commit_message = ' -m "" -m "' + STDIN.gets.chomp + '"'
else
  puts usage_error_message
  exit
end

# puts 'version was: ' + plist['CFBundleVersion']
plist['CFBundleVersion'] = '%d.%d.%d.%d' % [v1, v2, v3, rc]
# puts 'version is: ' + plist['CFBundleVersion']
Xcodeproj::Plist.write_to_path(plist, plist_path)

project_path = './' + project_name + '.xcodeproj'
project = Xcodeproj::Project.open(project_path)
project.targets.each do |target|
  if target.name == project_name
    target.build_configurations.each do |config|
      # puts config.name + ' version name was: ' + config.build_settings['BundleVersionsStringShort']
      if config.name == 'Release'
        config.build_settings['BundleVersionsStringShort'] = '%d.%d.%d' % [v1, v2, v3]
      else
        config.build_settings['BundleVersionsStringShort'] = '%d.%d.%d-RC%02d' % [v1, v2, v3, rc]
      end
    end
  end
end
project.save()

stdin, stdout, stderr = Open3.popen3('git branch | sed -n \'/\* /s///p\'')
branch_name = stdout.gets
rc_version_name = 'v%d.%d.%d-RC%d' % [v1, v2, v3, rc]
commit_message = '-m "Release ' + rc_version_name + '."'
puts line
puts '# Commit'
system('git commit -a ' + commit_message + additional_commit_message)
puts ''
puts line
puts '# Push commit'
system('git push origin ' + branch_name)
puts ''
if trigger_type == RC_TYPE
  puts line
  puts '# Add and push tag'
  system('git tag ' + rc_version_name)
  system('git push origin ' + rc_version_name)
  puts ''
  puts line
  puts '# Bitrise build trigger api'
  system('curl ' + bitrise_trigger_url + ' --data \'{"hook_info":{"type":"bitrise","api_token":"QPbypTzIfHAuryDatA79lA"},"build_params":{"tag":"' + rc_version_name + '", "workflow_id":"fastlane"}}\'')
  puts ''
end
