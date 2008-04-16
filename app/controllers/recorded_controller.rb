class RecordedController < ApplicationController
  
  def list
    @recordings = Recorded.find(:all, :order => params[:order])
    render :xml => @recordings
  end
  
  def get_recording
    starttime = Time.at(params[:starttime].to_i)
    @recording = Recorded.find_by_chanid_and_starttime(params[:chanid], starttime) 
    render :xml => @recording
  end
  
end
