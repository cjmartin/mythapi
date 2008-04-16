class Recorded < MythBase
  set_table_name "recorded"
  set_primary_keys :chanid, :starttime
end