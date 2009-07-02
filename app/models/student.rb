require 'misc_utils'
require 'unquoted_csv'

class Student < ActiveRecord::Base
  SCHOOL_OPTIONS = {
    102 => 'District Office',
    103 => 'Bacich Elementary School',
    104 => 'Kent Middle School'
  }
  GRADE_LEVEL_OPTIONS = {
    -1 => 'Pre-K',
    0 => 'K',
    1 => '1',
    2 => '2',
    3 => '3',
    4 => '4',
    5 => '5',
    6 => '6',
    7 => '7',
    8 => '8',
    99 => 'Graduated'
  }
  ENROLL_STATUS_OPTIONS = {
    -1 => 'Pre-Registered',
    0 => 'Active',
    1 => 'Inactive',
    2 => 'Transferred Out',
    3 => 'Graduated',
    4 => 'Imported As Historical',
    99 => 'Deleted'
  }
  
  acts_as_audited # :except => [:student_number]
  validates_uniqueness_of :network_id, :allow_nil => true
  validates_uniqueness_of :web_id, :allow_nil => true
  validates_uniqueness_of :student_web_id, :allow_nil => true
  
  def record_title
    "S-#{id} #{last_name}, #{first_name} (#{GRADE_LEVEL_OPTIONS[grade_level]})"
  end

  def info
    [ "<p>Student Number: <strong>#{id}</strong>",
      "<br />Status: <strong>#{ENROLL_STATUS_OPTIONS[enroll_status]}</strong>",
      "<br />School: <strong>#{SCHOOL_OPTIONS[schoolid]}</strong>",
      "<br />Grade Level: <strong>#{GRADE_LEVEL_OPTIONS[grade_level]}</strong>",
      "<br />Home ID: <strong>#{home_id}</strong>",
      "<br />Home2 ID: <strong>#{home2_id}</strong></p>" ].join("\n")
  end
  
  class << self
    def has_attribute?(key)
      column_names.include?(key.to_s)
    end

    def current_students
      find(:all, :conditions => ['enroll_status<=0'])
    end

    def load!(fname="student.export.text", audit=true)
      fname = File.join(Rails.root, "data", fname) unless fname[0,1] == '/'
      csv_options = { :col_sep => "\t", :row_sep => "\n" }
      csv_options[:headers] = true
      csv_options[:header_converters] = :symbol
      count = 0
      all_ids = Student.find(:all, :select => 'id').inject({}) { |h, stu| h[stu.id] = true; h }
      UnquotedCSV.foreach(fname, csv_options) do |row|
        count += 1
        attrs = row.to_hash
        stu = import_student(attrs, audit)
        all_ids.delete(stu.id) if stu
      end
      # check for deleted records here
      puts "deleting #{all_ids.keys.inspect}"
      all_ids.keys.each do |id|
        stu = Student.find(id) rescue nil
        next unless stu
        stu.enroll_status = 99
        if audit
          stu.save
        else
          stu.save_without_auditing
        end
      end
      count
    end

    def import_student(attrs, audit)
      student_number = (attrs.delete(:student_number) || 0).to_i
      if student_number == 0
        puts "bad student record #{attrs.inspect}"
        return nil
      end

      student_attrs = attrs.reject { |k, v| !has_attribute?(k) }
      int_convert(student_attrs, :home_id)
      int_convert(student_attrs, :home2_id)
      int_convert(student_attrs, :enroll_status)
      int_convert(student_attrs, :schoolid)
      int_convert(student_attrs, :grade_level)
      email_convert(student_attrs, :mother_email)
      email_convert(student_attrs, :father_email)
      email_convert(student_attrs, :mother2_email)
      email_convert(student_attrs, :father2_email)

      stu = Student.find(student_number) rescue nil
      if stu
        stu.attributes = student_attrs
        puts "#{stu.id} updated"
      else
        stu = Student.new(student_attrs)
        stu.id = student_number
        puts "#{stu.id} created"
      end
      if audit
        stu.save
      else
        stu.save_without_auditing
      end
      stu
    end

    def family_students(*home_ids)
      find(:all, 
        :conditions => ['(home_id<>0 AND home_id IN (?)) OR (home2_id<>0 AND home2_id IN (?))', home_ids, home_ids],
        :order => ['last_name,first_name'])
    end

    def family_emails(*home_ids)
      emails = family_students.inject({}) do |h, stu|
        h[stu.mother_email] = 1 if stu.mother_email
        h[stu.father_email] = 1 if stu.father_email
        h[stu.mother2_email] = 1 if stu.mother2_email
        h[stu.father2_email] = 1 if stu.father2_email
        h
      end.keys
    end

    def generate_ldif
      ou = APP_CONFIG[:ldap_student_container].match(/^ou=([^,]+)/)[1]
      student_ldif = <<END_LDIF
dn: #{ldap_student_container}
changetype: add
objectclass: top
objectclass: organizationalUnit
ou: #{ou}
description: Student open directory logins

END_LDIF

      ou = APP_CONFIG[:ldap_guardian_container].match(/^ou=([^,]+)/)[1]
      guardian_ldif = <<END_LDIF
dn: #{ldap_guardian_container}
changetype: add
objectclass: top
objectclass: organizationalUnit
ou: #{ou}
description: PowerSchool guardian logins

END_LDIF

      fname = "students.ldif"
      fname = File.join(Rails.root, "ldif", fname) unless fname[0,1] == '/'
      File.open(fname, "w") do |f|
        f.write(student_ldif)
        f.write(guardian_ldif)
        current_students.each do |stu|
          f.write(stu.ldif(ldap_guardian_container, ldap_student_container))
        end
      end
    end
  end
end
  
