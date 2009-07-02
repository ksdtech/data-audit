class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds, :force => true do |t|
      t.string   :name
      t.string   :permalink
      t.string   :record_type
      t.timestamps
    end
    
    create_table :feed_components, :force => true do |t|
      t.integer  :feed_id
      t.string   :attribute_name
      t.string   :match_old
      t.string   :match_new
      t.timestamps
    end

    Feed.create_builtin_feeds
  end

  def self.down
    drop_table :feed_components
    drop_table :feeds
  end
end
