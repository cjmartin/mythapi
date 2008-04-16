class MythBase < ActiveRecord::Base
  establish_connection "mythconverg"
end
