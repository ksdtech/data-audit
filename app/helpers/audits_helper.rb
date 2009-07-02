module AuditsHelper
  def audit_author_email(audit)
    audit.user ? "#{audit.user.email} (#{audit.user.full_name})" : "webmaster@kentfieldschools.org"
  end
  
  def audit_tag_url(audit, tag)
    "#{audit.auditable_type.underscore}/#{tag}"
  end
  
  def audit_title(audit)
    "#{audit.auditable_type} - #{audit.auditable.record_title}"
  end
  
  def audit_info(audit)
    audit.auditable.info
  end
  
  def audit_changes(feed, audit)
    lines = [ '<table border="1" class="audit"><tr><th width="150">Attribute</th><th width="150">Previous</th><th width="150">Current</th><th>Ver</th></tr>' ]
    ver = audit.version
    audit.changes_for_feed(feed).each do |ch|
      lines << "<tr><td>#{ch.attribute_name}</td><td>#{ch.old_value}</td><td>#{ch.new_value}</td><td>#{ver}</td></tr>"
    end
    lines << '</table>'
    lines.join("\n")
  end
end
