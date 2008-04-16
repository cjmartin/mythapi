class Video < ActiveRecord::Base
	UPLOAD_PATH="#{RAILS_ROOT}/public/videos/mythtv/"
	CONVERT_PATH="#{RAILS_ROOT}/public/videos/pvarchive/"
	
	def video=(video_file)
		@temp_file = video_file
		self.file_name = video_file.original_filename
		self.extend_object = self.file_name.split('.').last
	end
	
	def convert_path(filename=self.file_name)
		CONVERT_PATH + filename.sub(/(.\w+\z)/,"") + "mp4"
	end
	
	def upload_path(filename=self.file_name)
		UPLOAD_PATH + filename
	end
	
	def before_create
		logger.debug("about to save video to: " + upload_path)
		logger.debug("video will be converted to: " + convert_path)
		file.open(UPLOAD_PATH + self.file_name, "wb") do |f|
			f.write(@temp_file.read)
		end
	end
end
