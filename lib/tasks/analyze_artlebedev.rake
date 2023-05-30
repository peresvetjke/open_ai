# frozen_string_literal: true

# Usage example:
# bundle exec rake analyze_typograph\['/Users/i.udalov/Projects/open_ai/tmp/tasks/1685379458_fragments','fragments','_artlebedev'\]
desc 'Analyze typograph'
task :analyze_typograph, %i[dir list postfix] => :environment do |_, args|
  dir = args[:dir]
  list = args[:list]
  postfix = args[:postfix]

  work_dir = File.dirname("tmp/tasks/#{Time.now.to_i}_analyzing_typograph/.")
  FileUtils.mkdir_p(work_dir)
  $stdout.puts "Work dir: #{work_dir}"

  File.read(File.join(dir, list)).lines.each do |fragment|
    source_file_path = fragment.strip
    source = File.read(source_file_path)
    result_file_path = fragment.strip + postfix
    result_file_name = result_file_path.split('/').last
    result = File.read(result_file_path)

    analyzer = OpenAi::TypographAnalyzer.new
    if analyzer.call([[source, result]])
      $stdout.puts 'success for fragment :)'
      File.write(File.join(work_dir, result_file_name), analyzer.result)
    else
      $stdout.puts analyzer.errors
    end
    sleep 20
  end
end
