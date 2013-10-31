# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :minitest, include: %w[lib], cli: '- --tapy | tapout pretty' do
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/config_test\.rb$})      { 'test' }
end
