require 'rvideo'

class TranscodeProcessor < ApplicationProcessor
  subscribes_to :transcode

  def on_message(message)
    payload = YAML::load(message)
    transcode_file( payload.ivars['id'], payload.iavrs['src'], payload.ivars['dst'] )
  end
end
