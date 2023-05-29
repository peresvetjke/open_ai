# frozen_string_literal: true

# Usage example:
# bundle exec rake combine_results\['/Users/i.udalov/Projects/open_ai/tmp/tasks/1685379579_analyzing_typograph/1335734_1_artlebedev'\]
desc 'Combine results'
task :combine_results, %i[dir] => :environment do |_, args|
  dir = args[:dir]
  source_files = Dir[File.join(dir, '*')]


  $stdout.puts('Done!')
end
