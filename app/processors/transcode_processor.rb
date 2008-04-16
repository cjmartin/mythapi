class TranscodeProcessor < ApplicationProcessor

  subscribes_to :transcode

  def on_message(message)
    logger.debug "TranscodeProcessor received: " + message
  end
end