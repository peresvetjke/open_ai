# frozen_string_literal: true

# Usage example:
# bundle exec rake sum_up_reports\['/Users/i.udalov/Projects/open_ai/tmp/tasks/1685429655_analyzing_typograph','artlebedev'\]
desc 'Sum up typographs reports'
task :sum_up_reports, %i[dir postfix] => :environment do |_, args|
  dir = args[:dir]
  postfix = args[:postfix]
  source_files = Dir[File.join(dir, '*')].select { |f| f.end_with?(postfix) }
  reports = source_files.map { |f| File.read(f) }

  work_dir = File.dirname("tmp/tasks/#{Time.now.to_i}_#{postfix}_reports/.")
  FileUtils.mkdir_p(work_dir)
  $stdout.puts "Work dir: #{work_dir}"

  analyzer = OpenAi::ReportFinalizer.new

  reports.each_slice(5).with_index do |reps, i|
    if analyzer.call(reps)
      result_f = File.join(work_dir, "#{postfix}_report_#{i+1}")
      File.write(result_f, analyzer.result)
    else
      $stdout.puts(analyzer.errors)
    end
  end

  $stdout.puts('Done!')
end
