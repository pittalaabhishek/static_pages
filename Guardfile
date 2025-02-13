# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exist?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

# guard :minitest do
# with Minitest::Unit
# watch(%r{^test/(.*)\/?test_(.*)\.rb$})
# watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
# watch(%r{^test/test_helper\.rb$})      { 'test' }

# guard :minitest, spring: "bin/rails test", all_on_start: false do
# watch(%r{^test/(.*)/?(.*)_test\.rb$})
# watch('test/test_helper.rb') { 'test' }
# watch(%r{^app/(.*)$}) { 'test' }
# end


# with Minitest::Spec
# watch(%r{^spec/(.*)_spec\.rb$})
# watch(%r{^lib/(.+)\.rb$})         { |m| "spec/#{m[1]}_spec.rb" }
# watch(%r{^spec/spec_helper\.rb$}) { 'spec' }

# Rails 4
# watch(%r{^app/(.+)\.rb$})                               { |m| "test/#{m[1]}_test.rb" }
# watch(%r{^app/controllers/application_controller\.rb$}) { 'test/controllers' }
# watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "test/integration/#{m[1]}_test.rb" }
# watch(%r{^app/views/(.+)_mailer/.+})                    { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
# watch(%r{^lib/(.+)\.rb$})                               { |m| "test/lib/#{m[1]}_test.rb" }
# watch(%r{^test/.+_test\.rb$})
# watch(%r{^test/test_helper\.rb$}) { 'test' }

# Rails < 4
# watch(%r{^app/controllers/(.*)\.rb$}) { |m| "test/functional/#{m[1]}_test.rb" }
# watch(%r{^app/helpers/(.*)\.rb$})     { |m| "test/helpers/#{m[1]}_test.rb" }
# watch(%r{^app/models/(.*)\.rb$})      { |m| "test/unit/#{m[1]}_test.rb" }
# end

guard :minitest, spring: "bin/rails test", all_on_start: false do
  # Watch test files
  watch(%r{^test/(.*)_test\.rb$})

  # Watch for changes in controller files
  watch(%r{^app/controllers/(.*?)_controller\.rb$}) do |matches|
    resource_tests(matches[1])
  end


  # Watch the routes file
  watch('config/routes.rb') { integration_tests }

  # Watch view files (.erb) and trigger controller and integration tests
  watch(%r{^app/views/([^/]*?)/.*\.html\.erb$}) do |matches|
    [
      "test/controllers/#{matches[1]}_controller_test.rb",
      integration_tests(matches[1])
    ].flatten
  end

  # Watch helper files and trigger related tests
  watch(%r{^app/helpers/(.*)_helper\.rb$}) do |matches|
    "test/helpers/#{matches[1]}_helper_test.rb"
  end
end

# Returns all tests for the given resource.
def resource_tests(resource)
  controller_test(resource) + integration_tests(resource)
end

# Returns the controller test for the given resource.
def controller_test(resource)
  "test/controllers/#{resource}_controller_test.rb"
end

# Returns the integration tests for the given resource.
def integration_tests(resource = :all)
  if resource == :all
    Dir["test/integration/*"]
  else
    Dir["test/integration/#{resource}_*.rb"]
  end
end
