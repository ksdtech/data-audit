class AddAuditsTable < ActiveRecord::Migration
  def self.up
    create_table :audits, :force => true do |t|
      t.integer  :auditable_id
      t.string   :auditable_type
      t.integer  :user_id
      t.string   :user_type
      t.string   :username
      t.string   :action
      # t.text :changes
      t.integer  :version, :default => 0
      t.datetime :created_at
    end
    
    add_index :audits, [:auditable_id, :auditable_type], :name => 'auditable_index'
    add_index :audits, [:user_id, :user_type], :name => 'user_index'
    add_index :audits, :created_at  
    
    create_table :audit_changes, :force => true do |t|
      t.integer  :audit_id
      t.string   :attribute_name
      t.text     :old_value
      t.text     :new_value
    end
    
    add_index :audit_changes, [:audit_id]
    add_index :audit_changes, [:attribute_name]
  end

  def self.down
    drop_table :audit_changes
    drop_table :audits
  end
end
