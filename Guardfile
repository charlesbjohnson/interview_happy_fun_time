guard :minitest, include: %w[lib], cli: '- --tapy | tapout dot' do
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/config_test\.rb$})      { 'test' }
end

guard :rubocop, cli: '--lint' do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
