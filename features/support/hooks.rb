require 'sauce'

# Rewind meteor port number after meteor/rails feature tests
Around('@meteor, @rails') do |scenario, block|
  meteor_port = Sauce::Settings.ports.meteor
  rails_port = Sauce::Settings.ports.rails
  block.call
  Sauce::Settings['ports']['meteor'] = meteor_port
  Sauce::Settings['ports']['rails'] = rails_port
  Sauce::Settings.save!
end

Before do
  @aruba_timeout_seconds = 360
end
