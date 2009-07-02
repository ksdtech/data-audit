class AuditChange < ActiveRecord::Base
  belongs_to :audit
  serialize :old_value
  serialize :new_value
end
