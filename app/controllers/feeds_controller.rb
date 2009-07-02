class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end
  
  def show
    @feed = Feed.find(:first, :conditions => ['permalink=?', params[:id]]) or raise ActiveRecord::RecordNotFound
    respond_to do |format|
      format.rss
      format.html
    end
  end
  
  def new
    @feed = Feed.new
  end
  
  def create
    @feed = Feed.new(params[:feed])
    if @feed.save
      flash[:notice] = "Successfully created auditfeed."
      redirect_to @feed
    else
      render :action => 'new'
    end
  end
  
  def edit
    @feed = Feed.find(params[:id])
  end
  
  def update
    @feed = Feed.find(params[:id])
    if @feed.update_attributes(params[:feed])
      flash[:notice] = "Successfully updated auditfeed."
      redirect_to @feed
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    flash[:notice] = "Successfully destroyed auditfeed."
    redirect_to feeds_url
  end
end
