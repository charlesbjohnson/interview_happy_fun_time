guard :minitest, include: %w(lib) do
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/config_test\.rb$})      { 'test' }
end

guard :rubocop, keep_failed: false, notification: false, cli: '--lint' do
  watch(/^.+\.rb$/)
end
