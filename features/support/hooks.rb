require 'sauce'

# Rewind meteor port number after meteor feature tests
Around('@meteor') do |scenario, block|
  meteor_port = Sauce::Settings.ports.meteor
  block.call
  Sauce::Settings['ports']['meteor'] = meteor_port
  Sauce::Settings.save!
end

Before do
  @aruba_timeout_seconds = 20
end
