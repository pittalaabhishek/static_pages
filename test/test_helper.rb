ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
<<<<<<< HEAD
require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


=======
require 'minitest/reporters'
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)
>>>>>>> toy_app/main

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
<<<<<<< HEAD
end
=======
end
>>>>>>> toy_app/main
