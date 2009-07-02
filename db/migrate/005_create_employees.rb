class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees, :force => true do |t|
      # t.integer :teachernumber, :null => false, :default => 0
      t.timestamps
      
      t.text    :alert_medical
      t.string  :cable_lock_id, :limit => 15 
      t.string  :cell, :limit => 30
      t.boolean :certificated
      t.string  :city, :limit => 30 
      t.boolean :classified
      t.string  :dob, :limit => 10
      t.string  :doctor_name, :limit => 60 
      t.string  :doctor_phone, :limit => 30 
      t.string  :email_addr, :limit => 60 
      t.string  :email_personal, :limit => 60 
      t.string  :emerg1_phone1, :limit => 30 
      t.string  :emerg1_phone1_type, :limit => 15 
      t.string  :emerg1_phone2, :limit => 30 
      t.string  :emerg1_phone2_type, :limit => 15 
      t.string  :emerg1_rel, :limit => 15 
      t.string  :emerg2_phone1, :limit => 30 
      t.string  :emerg2_phone1_type, :limit => 15 
      t.string  :emerg2_phone2, :limit => 30 
      t.string  :emerg2_phone2_type, :limit => 15 
      t.string  :emerg2_rel, :limit => 15 
      t.string  :emergency1_first, :limit => 30 
      t.string  :emergency1_last, :limit => 30 
      t.string  :emergency2_first, :limit => 30 
      t.string  :emergency2_last, :limit => 30 
      t.string  :ethnicity, :limit => 30 
      t.string  :first_name, :limit => 30 
      t.string  :form0_updated_at, :limit => 30 
      t.string  :form0_updated_by, :limit => 30 
      t.string  :gender, :limit => 1 
      t.integer :group
      t.string  :groups, :limit => 255, :null => false
      t.string  :homeroom, :limit => 30 
      t.string  :home_phone, :limit => 30 
      t.string  :laptop_info, :limit => 30 
      t.string  :laptop_name, :limit => 30 
      t.string  :laptop_serialnumber, :limit => 30 
      t.string  :laptop_tag, :limit => 9 
      t.string  :last_name, :limit => 30 
      t.string  :loginid, :limit => 30 
      t.string  :medical_carrier, :limit => 60 
      t.string  :medical_phone, :limit => 30 
      t.string  :medical_policy, :limit => 30 
      t.string  :middle_name, :limit => 30 
      t.string  :network_id, :limit => 30 
      t.string  :network_password, :limit => 30 
      t.string  :powergradepw, :limit => 30 
      t.string  :preferredname, :limit => 30 
      t.integer :schoolid, :null => false, :default => 102
      t.string  :school_phone, :limit => 30 
      t.string  :school_phone_ext, :limit => 15 
      t.integer :staffstatus, :null => false, :default => 0
      t.string  :state, :limit => 2 
      t.integer :status, :null => false, :default => 1
      t.string  :street, :limit => 60 
      t.string  :teacherloginid, :limit => 30 
      t.string  :teacherloginpw, :limit => 30 
      t.string  :title, :limit => 60 
      t.string  :voice_mail, :limit => 30 
      t.string  :voice_mail_ext, :limit => 15 
      t.string  :zip, :limit => 15
    end
    
    add_index :employees, [:network_id]
    add_index :employees, [:loginid]
    add_index :employees, [:teacherloginid]
  end

  def self.down
    drop_table :employees
  end
end
