module Sauce
  module Generators
    module Meteor
      class AppGenerator < Thor::Group
        include Thor::Actions

        argument :name, desc: 'application name', type: :string
        def initialize(args = ARGV, opts = {}, cfg = {})
          super
          run %{mkdir #{@name}}
        end
      end
    end
  end
end
