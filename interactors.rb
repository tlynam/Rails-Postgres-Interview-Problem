require 'irb'

# Assume you're working with a codebase that has a bunch of interactor-like classes.
# Those classes have an API much like a Proc.
# In this magical realm our `call` methods are pure functions. Design a library
# or patch that will allow us to memoize calls to `call`

module Interactors
  module Memoize
    def call(*args)
      @call ||= super(*args)
    end
  end
end

module Interactors
  class Base; end
end

module Interactors
  class Greeting < Base
    prepend Memoize

    def initialize(*args)
      @name = args.first
    end

    def call(*args)
      welcome_message
    end

    def call2(*args)
      welcome_message
    end

    private

    def welcome_message
      "Hello #{@name}"
    end
  end
end

greeting = Interactors::Greeting.new("Bob")
greeting.call
puts greeting.instance_variable_get(:@call)

# binding.irb
