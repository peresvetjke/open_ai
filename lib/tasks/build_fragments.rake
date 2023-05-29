# frozen_string_literal: true

# Usage example:
# bundle exec rake build_fragments\['/Users/i.udalov/Documents/TaskNotes/UCMS_10032/source_articles'\]
desc 'Split files to fragments'
task :build_fragments, %i[dir] => :environment do |_, args|
  dir = args[:dir]
  source_files = Dir[File.join(dir, '*')]

  work_dir = File.dirname("tmp/tasks/#{Time.now.to_i}_fragments/.")
  FileUtils.mkdir_p(work_dir)

  fragments_list = File.open(File.join(work_dir, 'fragments'), 'a')

  source_files.each do |source_file|
    source_file_name = source_file.split('/').last.split('.').first

    File.read(source_file).lines.each_slice(20).with_index do |fragment, i|
      source_fragment_path = File.join(work_dir, "#{source_file_name}_#{i+1}")
      File.write(source_fragment_path, fragment.join)
      fragments_list.write("#{source_fragment_path}\n")
    end
  end
  fragments_list.close

  $stdout.puts "Files were splitted to fragments: #{work_dir}"
end
