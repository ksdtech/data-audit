require 'misc_utils'
require 'unquoted_csv'

class Employee < ActiveRecord::Base
  SCHOOL_OPTIONS = {
    102 => 'District Office',
    103 => 'Bacich Elementary School',
    104 => 'Kent Middle School'
  }
  STATUS_OPTIONS = {
    1 => 'Current',
    2 => 'No Longer Here',
    99 => 'Deleted'
  }
  STAFFSTATUS_OPTIONS = {
    0 => 'Not Assigned',
    1 => 'Teacher',
    2 => 'Staff',
    3 => 'Lunch Staff',
    4 => 'Substitute'
  }
  
  acts_as_audited # :except => [:teachernumber]
  validates_uniqueness_of :network_id, :allow_nil => true
  validates_uniqueness_of :loginid, :allow_nil => true
  validates_uniqueness_of :teacherloginid, :allow_nil => true
  
  def record_title
    "E-#{id} #{last_name}, #{first_name}"
  end
  
  def info
    [ "<p>Teacher Number: <strong>#{id}</strong>",
      "<br />Status: <strong>#{STATUS_OPTIONS[status]}</strong>",
      "<br />Staff Status: <strong>#{STAFFSTATUS_OPTIONS[staffstatus]}</strong>",
      "<br />Title: <strong>#{title}</strong>",
      "<br />School: <strong>#{SCHOOL_OPTIONS[schoolid]}</strong></p>" ].join("\n")
  end
  
  class << self
    def has_attribute?(key)
      column_names.include?(key.to_s)
    end
    
    def current_employees
      find(:all, :conditions => ['status=1'])
    end

    def load!(fname="export.txt", audit=true)
      fname = File.join(Rails.root, "data", fname) unless fname[0,1] == '/'
      csv_options = { :col_sep => "\t", :row_sep => "\n" }
      csv_options[:headers] = true
      csv_options[:header_converters] = :symbol
      count = 0
      all_ids = Employee.find(:all, :select => 'id').inject({}) { |h, emp| h[emp.id] = true; h }
      UnquotedCSV.foreach(fname, csv_options) do |row|
        count += 1
        attrs = row.to_hash
        emp = import_employee(attrs, audit)
        all_ids.delete(emp.id) if emp
      end
      # check for deleted records here
      puts "deleting #{all_ids.keys.inspect}"
      all_ids.keys.each do |id|
        emp = Employee.find(id) rescue nil
        next unless emp
        emp.status = 99
        if audit
          emp.save
        else
          emp.save_without_auditing
        end
      end
      count
    end

    def import_employee(attrs, audit)
      int_convert(attrs, :teachernumber)
      teachernumber = attrs.delete(:teachernumber)
      if teachernumber == 0
        puts "bad employee record #{attrs.inspect}"
        return nil
      end
      
      employee_attrs = attrs.reject { |k, v| !has_attribute?(k) }
      int_convert(employee_attrs, :status)
      int_convert(employee_attrs, :staffstatus)
      int_convert(employee_attrs, :schoolid)
      email_convert(employee_attrs, :email_addr)
      list_convert(employee_attrs, :groups)

      emp = Employee.find(teachernumber) rescue nil
      if emp
        emp.attributes = employee_attrs
        puts "#{emp.id} updated"
      else
        emp = Employee.new(employee_attrs)
        emp.id = teachernumber
        puts "#{emp.id} created"
      end
      if audit
        emp.save
      else
        emp.save_without_auditing
      end
      emp
    end
    
    def generate_ldif
      ou = APP_CONFIG[:ldap_staff_container].match(/^ou=([^,]+)/)[1]
      employee_ldif = <<END_LDIF
dn: #{ldap_container}
changetype: add
objectclass: top
objectclass: organizationalUnit
ou: #{ou}
description: Staff open directory logins

END_LDIF

      fname = "employees.ldif"
      fname = File.join(Rails.root, "ldif", fname) unless fname[0,1] == '/'
      File.open(fname, "w") do |f|
        f.write(employee_ldif)
        current_employees.each do |emp|
          f.write(emp.ldif(ldap_container))
        end
      end
    end
  end
end
