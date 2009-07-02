class FeedComponentsController < ApplicationController
  def index
    @feed_components = FeedComponent.all
  end
  
  def show
    @feed_component = FeedComponent.find(params[:id])
  end
  
  def new
    @feed_component = FeedComponent.new
  end
  
  def create
    @feed_component = FeedComponent.new(params[:feed_component])
    if @feed_component.save
      flash[:notice] = "Successfully created auditfeedattribute."
      redirect_to @feed_component
    else
      render :action => 'new'
    end
  end
  
  def edit
    @feed_component = FeedComponent.find(params[:id])
  end
  
  def update
    @feed_component = FeedComponent.find(params[:id])
    if @feed_component.update_attributes(params[:feed_component])
      flash[:notice] = "Successfully updated auditfeedattribute."
      redirect_to @feed_component
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @feed_component = FeedComponent.find(params[:id])
    @feed_component.destroy
    flash[:notice] = "Successfully destroyed auditfeedattribute."
    redirect_to feed_components_url
  end
end
