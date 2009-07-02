class AuditsController < ApplicationController
  def show
    @feed = Feed.find(:first, :conditions => ['permalink=?', params[:feed_id]]) or raise ActiveRecord::RecordNotFound
    @audit = @feed.audit(params[:id]) or raise ActiveRecord::RecordNotFound
  end
end
