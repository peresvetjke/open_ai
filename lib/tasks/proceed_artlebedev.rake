# frozen_string_literal: true

# Usage example:
# bundle exec rake proceed_artlebedev\['/Users/i.udalov/Projects/open_ai/tmp/tasks/1685379458_fragments'\]
desc 'Proceed files by artlebedev'
task :proceed_artlebedev, %i[dir] => :environment do |_, args|
  dir = args[:dir]
  source_files = Dir[File.join(dir, '*')]

  source_files.each_with_index do |source_file, i|
    source_file = source_file.split('/').last.split('.').first

    result_file = "#{source_file}_artlebedev"
    #{File.join(dir, source_file)}

    `python vendor/artlebedev/example-utf.py '#{File.join(dir, source_file)}' '#{File.join(dir, result_file)}'`
  end

  $stdout.puts('Done!')
end
