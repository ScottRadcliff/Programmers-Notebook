require 'tork/config'
Tork::Config.all_test_file_globs << 'features/**/*.feature'


Tork::Config.test_file_globbers.update(
  # source files that correspond to test files
  %r<^(features/(.+/)?)step_definitions/.+\.rb$> => lambda do |path, matches|
    matches[1] + '*.feature'
  end,

  # the actual test files themselves
  %r<^features/.+\.feature$> => lambda {|path, matches| path }
)

Tork::Config.after_fork_hooks.push lambda { |test_file, line_numbers, log_file, worker_number| 

  if File.extname(test_file) == '.feature'
    puts "here"
    # pass test_file in ARGV to cucumber(1) for running
    ARGV << [test_file, *line_numbers].join(':')
    require 'cucumber'
    require 'rubygems'
    cucumber_bin = Gem.bin_path('cucumber', 'cucumber')
    at_exit { load cucumber_bin unless $! }

    # noopify loading of test_file in Tork::Master#test()
    # because cucumber feature files are not Ruby scripts
    require 'tempfile'
    test_file.replace Tempfile.new('tork-cucumber').path
  end
}
