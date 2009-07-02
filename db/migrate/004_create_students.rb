class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students, :force => true do |t|
      # t.integer :student_number, :null => false, :default => 0
      t.timestamps
      
      # fields from reg-export
      t.text    :alert_medical 
      t.text    :alert_medical_symptoms 
      t.text    :alert_medical_what 
      t.text    :allergies 
      t.boolean :allergies_benadryl 
      t.boolean :allergies_drugs 
      t.boolean :allergies_epi_pen 
      t.boolean :allergies_food 
      t.boolean :allergies_insects 
      t.boolean :allergies_other 
      t.boolean :allergies_severe 
      t.boolean :allowwebaccess 
      t.boolean :asthma 
      t.boolean :asthma_inhaler 
      t.boolean :asthma_medication 
      t.text    :behavior_issues 
      t.boolean :behavior_problems 
      t.string  :ca_birthplace_city, :limit => 30
      t.string  :ca_birthplace_country, :limit => 2 
      t.string  :ca_birthplace_state, :limit => 2
      t.string  :ca_dateenroll, :limit => 10 
      t.string  :ca_daterfep, :limit => 10 
      t.boolean :ca_ethnaa 
      t.boolean :ca_ethnai 
      t.boolean :ca_ethnaspiai 
      t.boolean :ca_ethnaspica 
      t.boolean :ca_ethnaspich 
      t.boolean :ca_ethnaspigu 
      t.boolean :ca_ethnaspiha 
      t.boolean :ca_ethnaspija 
      t.boolean :ca_ethnaspiko 
      t.boolean :ca_ethnaspila 
      t.boolean :ca_ethnaspioa 
      t.boolean :ca_ethnaspiopi 
      t.boolean :ca_ethnaspisa 
      t.boolean :ca_ethnaspita 
      t.boolean :ca_ethnaspivi 
      t.boolean :ca_ethnfi 
      t.boolean :ca_ethnla 
      t.boolean :ca_ethnwh 
      t.string  :ca_firstusaschooling, :limit => 10 
      t.string  :ca_homelanguage, :limit => 2
      t.string  :ca_langfluency, :limit => 1
      t.string  :ca_namesuffix, :limit => 30
      t.string  :ca_parented, :limit => 2
      t.string  :city, :limit => 30
      t.boolean :custody_orders 
      t.string  :dental_carrier, :limit => 60
      t.string  :dental_policy, :limit => 30
      t.string  :dentist_name, :limit => 60
      t.string  :dentist_phone, :limit => 30
      t.boolean :diabetes 
      t.boolean :diabetes_insulin 
      t.string  :districtentrydate 
      t.string  :districtentrygradelevel 
      t.string  :dob, :limit => 10 
      t.string  :doctor_name, :limit => 60
      t.string  :doctor_phone, :limit => 30
      t.string  :doctor2_name, :limit => 60
      t.string  :doctor2_phone, :limit => 30
      t.string  :electives_5_music, :limit => 15
      t.string  :electives_6_band 
      t.string  :electives_6_choir 
      t.string  :electives_7_band 
      t.string  :electives_7_choir 
      t.string  :electives_8_band 
      t.string  :electives_8_choir 
      t.string  :electives_8_enrich1, :limit => 15
      t.string  :electives_8_enrich2, :limit => 15
      t.string  :electives_8_enrich3, :limit => 15
      t.string  :emerg_1_alt_phone, :limit => 30
      t.string  :emerg_1_alt_ptype, :limit => 15
      t.string  :emerg_1_first, :limit => 30
      t.string  :emerg_1_ptype, :limit => 15
      t.string  :emerg_1_rel, :limit => 15
      t.string  :emerg_2_alt_phone, :limit => 30
      t.string  :emerg_2_alt_ptype, :limit => 15
      t.string  :emerg_2_first, :limit => 30
      t.string  :emerg_2_ptype, :limit => 15
      t.string  :emerg_2_rel, :limit => 15
      t.string  :emerg_3_alt_phone, :limit => 30
      t.string  :emerg_3_alt_ptype, :limit => 15
      t.string  :emerg_3_first, :limit => 30
      t.string  :emerg_3_last, :limit => 30
      t.string  :emerg_3_phone, :limit => 30
      t.string  :emerg_3_ptype, :limit => 15
      t.string  :emerg_3_rel, :limit => 15
      t.string  :emerg_contact_1, :limit => 30
      t.string  :emerg_contact_2, :limit => 30
      t.string  :emerg_phone_1, :limit => 30
      t.string  :emerg_phone_2, :limit => 30
      t.string  :emerg_x_alt_phone, :limit => 30
      t.string  :emerg_x_alt_ptype, :limit => 15
      t.string  :emerg_x_first, :limit => 30
      t.string  :emerg_x_last, :limit => 30
      t.string  :emerg_x_phone, :limit => 30
      t.string  :emerg_x_ptype, :limit => 15
      t.string  :emerg_x_rel, :limit => 15
      t.string  :emergency_hospital, :limit => 30
      t.boolean :emergency_meds 
      t.boolean :emergency_meds_complete 
      t.integer :enroll_status, :null => false, :default => 0
      t.string  :entrydate, :limit => 10
      t.string  :ethnicity, :limit => 3
      t.string  :exitcode, :limit => 3 
      t.boolean :eyeglasses 
      t.boolean :eyeglasses_always 
      t.boolean :eyeglasses_board 
      t.boolean :eyeglasses_reading 
      t.string  :father, :limit => 30 
      t.string  :father_cell, :limit => 30
      t.string  :father_email, :limit => 60
      t.string  :father_email2, :limit => 60
      t.string  :father_employer, :limit => 30
      t.string  :father_employer_address, :limit => 30
      t.string  :father_first, :limit => 30
      t.string  :father_home_phone, :limit => 30
      t.boolean :father_isguardian 
      t.string  :father_pager 
      t.string  :father_rel, :limit => 15
      t.integer :father_staff_id 
      t.string  :father_work_phone, :limit => 30
      t.string  :father2_cell, :limit => 30
      t.string  :father2_email, :limit => 60
      t.string  :father2_email2, :limit => 60
      t.string  :father2_employer, :limit => 30
      t.string  :father2_employer_address, :limit => 30
      t.string  :father2_first, :limit => 30
      t.string  :father2_home_phone, :limit => 30
      t.boolean :father2_isguardian 
      t.string  :father2_last, :limit => 30
      t.string  :father2_pager 
      t.string  :father2_rel, :limit => 15
      t.integer :father2_staff_id 
      t.string  :father2_work_phone, :limit => 30
      t.string  :first_name, :limit => 30
      t.string  :form1_updated_at, :limit => 30
      t.string  :form1_updated_by, :limit => 15
      t.string  :form2_updated_at, :limit => 30
      t.string  :form2_updated_by, :limit => 15
      t.string  :form3_updated_at, :limit => 30
      t.string  :form3_updated_by, :limit => 15
      t.string  :form4_updated_at, :limit => 30
      t.string  :form4_updated_by, :limit => 15
      t.string  :form5_updated_at, :limit => 30
      t.string  :form5_updated_by, :limit => 15
      t.string  :form6_updated_at, :limit => 30
      t.string  :form6_updated_by, :limit => 15
      t.string  :form7_updated_at, :limit => 30
      t.string  :form7_updated_by, :limit => 15
      t.string  :form8_updated_at, :limit => 30
      t.string  :form8_updated_by, :limit => 15
      t.string  :form9_updated_at, :limit => 30
      t.string  :form9_updated_by, :limit => 15
      t.string  :gender, :limit => 1
      t.integer :grade_level, :null => false, :default => 0
      t.string  :guardianemail 
      t.string  :h_hearing_aid 
      t.string  :h_last_eye_exam 
      t.string  :health_ins_type 
      t.integer :home_id, :null => false, :default => 0
      t.boolean :home_no_inet_access 
      t.string  :home_phone, :limit => 30
      t.boolean :home_printed_material 
      t.string  :home_room, :limit => 30
      t.boolean :home_spanish_material 
      t.string  :home2_city, :limit => 30
      t.integer :home2_id, :null => false, :default => 0
      t.boolean :home2_no_inet_access 
      t.string  :home2_phone, :limit => 30
      t.boolean :home2_printed_material 
      t.boolean :home2_spanish_material 
      t.string  :home2_state, :limit => 2
      t.string  :home2_street, :limit => 60
      t.string  :home2_zip, :limit => 15
      t.string  :homeroom_teacher, :limit => 30
      t.string  :homeroom_teacherfirst, :limit => 30
      t.string  :illness_desc 
      t.boolean :illness_recent 
      t.string  :lang_adults_primary, :limit => 2
      t.string  :lang_earliest, :limit => 2
      t.string  :lang_other, :limit => 2
      t.string  :lang_spoken_to, :limit => 2
      t.string  :last_name, :limit => 30
      t.string  :lastfirst, :limit => 60
      t.string  :lives_with_rel, :limit => 15
      t.string  :mailing_city, :limit => 30
      t.string  :mailing_state, :limit => 2
      t.string  :mailing_street, :limit => 60
      t.string  :mailing_zip, :limit => 15
      t.string  :mailing2_city, :limit => 30
      t.string  :mailing2_state, :limit => 2
      t.string  :mailing2_street, :limit => 60
      t.string  :mailing2_zip, :limit => 15
      t.string  :med1_dosage, :limit => 30
      t.string  :med1_hours, :limit => 30
      t.string  :med1_name, :limit => 30
      t.string  :med2_dosage, :limit => 30
      t.string  :med2_hours, :limit => 30
      t.string  :med2_name, :limit => 30
      t.string  :med3_dosage, :limit => 30
      t.string  :med3_hours, :limit => 30
      t.string  :med3_name, :limit => 30
      t.string  :medi_cal_num, :limit => 30
      t.boolean :medical_accom 
      t.text    :medical_accom_desc 
      t.string  :medical_carrier, :limit => 60
      t.text    :medical_considerations 
      t.boolean :medical_other 
      t.string  :medical_policy, :limit => 30
      t.string  :medication_summary 
      t.string  :middle_name, :limit => 30
      t.string  :mother, :limit => 30 
      t.string  :mother_cell, :limit => 30
      t.string  :mother_email, :limit => 60
      t.string  :mother_email2, :limit => 60
      t.string  :mother_employer, :limit => 30
      t.string  :mother_employer_address, :limit => 30
      t.string  :mother_first, :limit => 30
      t.string  :mother_home_phone, :limit => 30
      t.boolean :mother_isguardian 
      t.string  :mother_pager, :limit => 30
      t.string  :mother_rel, :limit => 15
      t.integer :mother_staff_id
      t.string  :mother_work_phone, :limit => 30
      t.string  :mother2_cell, :limit => 30
      t.string  :mother2_email, :limit => 60
      t.string  :mother2_email2, :limit => 60
      t.string  :mother2_employer, :limit => 30
      t.string  :mother2_employer_address, :limit => 30
      t.string  :mother2_first, :limit => 30
      t.string  :mother2_home_phone, :limit => 30
      t.boolean :mother2_isguardian 
      t.string  :mother2_last, :limit => 30
      t.string  :mother2_pager 
      t.string  :mother2_rel, :limit => 15
      t.integer :mother2_staff_id 
      t.string  :mother2_work_phone, :limit => 30
      t.boolean :movement_limits 
      t.text    :movement_limits_desc 
      t.string  :network_id, :limit => 30
      t.string  :network_password, :limit => 30
      t.string  :nickname, :limit => 30
      t.string  :optical_carrier, :limit => 60
      t.string  :optical_policy, :limit => 30
      t.text    :prescriptions 
      t.string  :prev_school_permission 
      t.string  :previous_school_address, :limit => 60
      t.string  :previous_school_city, :limit => 30
      t.string  :previous_school_grade_level, :limit => 15
      t.string  :previous_school_name, :limit => 30
      t.string  :previous_school_phone, :limit => 30
      t.boolean :pub_waiver_public 
      t.boolean :pub_waiver_restricted 
      t.integer :reg_grade_level 
      t.string  :reg_will_attend, :limit => 15
      t.boolean :release_authorization 
      t.boolean :requires_meds 
      t.string  :responsibility_date, :limit => 10 
      t.boolean :responsibility_signed
      t.boolean :school_meds 
      t.boolean :school_meds_complete 
      t.string  :schoolentrydate, :limit => 10  
      t.string  :schoolentrydate_ca, :limit => 10  
      t.integer :schoolentrygradelevel 
      t.integer :schoolid, :null => false, :default => 0 
      t.boolean :seizures 
      t.boolean :seizures_medication 
      t.string  :sibling1_dob, :limit => 10  
      t.string  :sibling1_name, :limit => 30
      t.string  :sibling2_dob, :limit => 10  
      t.string  :sibling2_name, :limit => 30
      t.string  :sibling3_dob, :limit => 10  
      t.string  :sibling3_name, :limit => 30
      t.string  :sibling4_dob, :limit => 10  
      t.string  :sibling4_name, :limit => 30
      t.string  :signature_1, :limit => 60
      t.string  :signature_2, :limit => 60
      t.string  :state, :limit => 2
      t.string  :street, :limit => 60
      t.boolean :student_allowwebaccess 
      t.string  :student_web_id, :limit => 30
      t.string  :student_web_password, :limit => 30
      t.string  :vol_first, :limit => 30
      t.boolean :vol_help 
      t.string  :vol_last, :limit => 30
      t.string  :vol_phone, :limit => 30
      t.text    :vol_qualifications 
      t.string  :web_id, :limit => 30
      t.string  :web_password, :limit => 30
      t.string  :zip, :limit => 15
    end
    
    add_index :students, [:network_id]
    add_index :students, [:web_id]
    add_index :students, [:student_web_id]
    add_index :students, [:home_id]
    add_index :students, [:home2_id]
  end

  def self.down
    drop_table :students
  end
end
