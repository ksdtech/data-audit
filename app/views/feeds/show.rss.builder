# app/views/feeds/index.rss.builder
xml.channel do
  # Required to pass W3C validation.
  xml.atom :link, nil, {
    :href => feed_url(@feed, :format => 'rss'),
    :rel => 'self', :type => 'application/rss+xml'
  }
  
  # required channel elements
  xml.title             @feed.name
  xml.description       @feed.name
  xml.link              feed_url(@feed, :format => 'rss')
  
  # optional channel elements
  xml.generator         'data-audit on rails'
  xml.docs              'http://www.rssboard.org/rss-specification'
  xml.ttl               240
  xml.language          'en-us'
  xml.copyright         'Copyright 2009, Kentfield School District'
  xml.managingEditor    'webmaster@kentfieldschools.org (Kentfield Schools Webmaster)'
  xml.webMaster         'webmaster@kentfieldschools.org (Kentfield Schools Webmaster)'
  xml.pubDate           @feed.last_updated_at.to_s(:rfc822)
  xml.lastBuildDate     Time.now.to_s(:rfc822)
  # xml.category
  # xml.cloud
  # xml.image
  # xml.rating
  # xml.textInput
  # xml.skipHours
  # xml.skipDays
  
  # Posts.
  @feed.audits.each do |audit|
    xml.item do
      xml.title         audit_title(audit)
      xml.link          feed_audit_url(@feed, audit)
      xml.description   do
        xml.cdata! (audit_info(audit) + audit_changes(@feed, audit))
      end
      xml.pubDate       audit.created_at.to_s(:rfc822)
      xml.guid          feed_audit_url(@feed, audit), :isPermalink => 'true'
      xml.author        audit_author_email(audit)
      xml.source        @feed.name, :url => feed_url(@feed, :format => 'rss')
      audit.tags_for_feed(@feed).each do |tag|
        xml.category    tag, :domain => audit_tag_url(audit, tag)
      end
      # xml.comments
      # xml.enclosure
    end
  end
end
