require 'active_record/fixtures'

class QuickFix
  def self.parse_yaml_string(fixture_content)
    YAML::load(erb_render(fixture_content))
  rescue => error
    raise Fixture::FormatError, "a YAML error occurred parsing #{yaml_file_path}. Please note that YAML must be consistently indented using spaces. Tabs are not allowed. Please have a look at http://www.yaml.org/faq.html\nThe exact error was:\n  #{error.class}: #{error}"
  end

  def self.erb_render(fixture_content)
    ERB.new(fixture_content).result
  end

  def self.load_fixtures(fixtures_directory, table_name)
    basename = File.join(fixtures_directory, table_name.to_s)
    parse_yaml_string(IO.read("#{basename}.yml"))
  end
end
