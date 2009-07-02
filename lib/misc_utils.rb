def ldif_escape(str)
  str.gsub(/[,+\"\\\<\>\;]/) { |c| "\\#{c}" }
end

def bool_convert(attrs, key)
  return if attrs[key].nil?
  test = attrs[key].to_s.downcase
  if ['true','t','1','yes','on'].include?(test)
    attrs[key] = true
  elsif ['false','f','0','no','off'].include?(test)
    attrs[key] = false
  end
end

def int_convert(attrs, key)
  # works with nil, too!
  attrs[key] = attrs[key].to_i
end

VALID_EMAIL = /^[_\-\.\+a-z0-9]+\@[_\-\.a-z0-9]+\.[a-z]+$/
def email_convert(attrs, key)
  email = (attrs[key] || '').strip.downcase
  if email.empty?
    email = nil
  elsif !email.match(VALID_EMAIL)
    puts "invalid #{key}: '#{email}'" 
    email = nil
  end
  attrs[key] = email
end

INVALID_NAME_CHARS = /[^-.'A-Za-z0-9]+/
def name_convert(attrs, key)
  name = (attrs[key] || '').gsub(INVALID_NAME_CHARS, ' ').strip
  attrs[key] = !name.empty? ? name : nil
end

def list_convert(attrs, key)
  attrs[key] ||= ''
end

def state_convert(attrs, key)
  name = (attrs[key] || '')[0,2].strip
  attrs[key] = !name.empty? ? name : nil
end
