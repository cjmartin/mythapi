require 'rvideo'

class TranscodeProcessor < ApplicationProcessor
  subscribes_to :transcode

  def on_message(message)
    payload = YAML::load(message)
    transcode_file( payload.ivars['id'], payload.iavrs['src'], payload.ivars['dst'] )
  end

	def transcode_file(id, src, destination)
		begin
			logger = Logger.new(STDOUT)
			RVideo::Transcoder.logger = logger
			file = RVideo::Inspector.new(:file => src)
			
			if file.width.to_i > 640
			  divisor = file.width.to_i/640
			  file.width = 640
			  file.height = file.height/divisor
		  end
			
			command = "nice -n 19 ffmpeg -i $input_file$ -y -threads 4 -croptop 6 -cropbottom 6 -cropleft 6 -cropright 6 -s $width$x$height$ -r 29.97 -vcodec libx264 -g 150 -qmin 25 -qmax 51 -b 1000k -maxrate 1450k -level 30 -loop 1 -sc_threshold 40 -refs 2 -keyint_min 40 -partp4x4 1 -rc_eq 'blurCplx^(1-qComp)' -deinterlace -async 50 -acodec libfaac -ar 48000 -ac 2 -ab 128k -f mp4 $output_file$"
			options = {
			  :input_file => src,
			  :output_file => destination,
			  :width => file.width,
			  :height => file.height
			}
			transcoder = RVideo::Transcoder.new
			transcoder.execute(command, options)
			@video = Video.find(id)
			@video.width = file.width
			@video.height = file.height
			@video.save
		end
	end
end
