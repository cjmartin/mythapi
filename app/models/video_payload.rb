class VideoPayload
	attr_accessor :id, :src, :dst
	
	def initialize(params)
		@id = params[:id]
		@src = params[:src]
		@dst = params[:dst]
	end
end