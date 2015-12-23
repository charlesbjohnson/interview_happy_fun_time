group :tests, halt_on_fail: true do
  guard :minitest, include: %w(lib) do
    watch(%r{^test/(.*)\/?test_(.*)\.rb$})
    watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
    watch(%r{^test/config_test\.rb$})      { 'test' }
  end

  guard :rubocop, keep_failed: false, notification: false do
    watch(/^.+\.rb$/)
  end
end

scope group: :tests
