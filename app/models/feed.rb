require 'quick_fix'

class Audit
  def changes_for_feed(feed)
    return [] unless self.auditable_type == feed.record_type
    changes.find(:all, :conditions => feed.audit_change_conditions)
  end
  
  def tags_for_feed(feed)
    changes_for_feed(feed).collect { |ch| ch.attribute_name }
  end
end

class Feed < ActiveRecord::Base
  has_many :components, :class_name => 'FeedComponent', :order => 'attribute_name'
  
  def to_param
    permalink
  end
  
  def last_updated_at
    a = Audit.find(:first, :conditions => audit_conditions, :joins => [:changes], :order => 'created_at DESC')
    a ? a.created_at : Time.now
  end  
  
  def audit_change_conditions
    if !@change_conds 
      c_str = ''
      conds = components.inject([]) do |arr, comp|
        c_str << " OR " if !c_str.empty?
        c_str << "(audit_changes.attribute_name=?"
        arr << comp.attribute_name
        if comp.match_old 
          c_str << " AND audit_changes.old_value REGEXP ?"
          arr << comp.match_old
        end
        if comp.match_new
          c_str << " AND audit_changes.new_value REGEXP ?"
          arr << comp.match_new
        end
        c_str << ")"
        arr
      end
      @change_conds = [c_str] + conds
    end
    @change_conds
  end
  
  def audit_conditions(ids=nil)
    if !@audit_conds
      change_conds = audit_change_conditions
      @audit_conds = ["audits.auditable_type=? AND (#{change_conds[0]})"] + [self.record_type] + change_conds[1, change_conds.size-1]
    end
    return @audit_conds unless ids
    ["audits.id IN (?) AND (#{@audit_conds[0]})", ids] + @audit_conds[1, @audit_conds.size-1]
  end
  
  def audit(id)
    Audit.find(:first, :conditions => audit_conditions([id]), :include => [:changes])
  end
  
  def audits(ids=nil)
    Audit.find(:all, :conditions => audit_conditions(ids), :include => [:changes], :order => 'created_at DESC')
  end
  
  class << self
    def create_builtin_feeds
      fixtures = QuickFix.load_fixtures('data', 'feeds')
      fixtures.each do |label, fixture|
        attrs = fixture.to_options # symbolize keys
        changes = attrs.delete(:changes)
        feed = Feed.create(attrs)
        changes.each do |attribute_name, arr|
          feed.components.create(:attribute_name => attribute_name, 
            :match_old => (arr.nil? || arr[0] == 'nil') ? nil : arr[0],
            :match_new => (arr.nil? || arr[1] == 'nil') ? nil : arr[1])
        end
      end
    end
  end
end
