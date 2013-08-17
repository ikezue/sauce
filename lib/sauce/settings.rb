require 'path'
require 'settingslogic'

module Sauce
  class Settings < Settingslogic
    source Path.dir / '..' / '..' / 'config' / 'settings.yml'
    load!

    def save!
      File.open self.class.source, 'w' do |f|
        f.write self.to_yaml
      end
      self.class.reload!
    end
  end
end
