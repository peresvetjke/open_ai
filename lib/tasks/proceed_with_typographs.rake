# frozen_string_literal: true

# Usage example:
# bundle exec rake proceed_with_typographs\['/Users/i.udalov/Projects/open_ai/tmp/tasks/1685379458_fragments'\]
desc 'Proceed files by typographs'
task :proceed_with_typographs, %i[dir] => :environment do |_, args|
  dir = args[:dir]
  source_files = Dir[File.join(dir, '*')]

  source_files.each_with_index do |source_file, i|
    source_file = source_file.split('/').last.split('.').first

    `python vendor/artlebedev/example-utf.py '#{File.join(dir, source_file)}' '#{File.join(dir, "#{source_file}_artlebedev")}'`
    `python vendor/mdash/run.py '#{File.join(dir, source_file)}' '#{File.join(dir, "#{source_file}_mdash")}'`
  end

  $stdout.puts('Done!')
end
