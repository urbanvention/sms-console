# defaults.rb ;; 2010 (cc) Jan Riethmayer
# This work is licensend under a Creative Commons Attribution 3.0 license.

class Defaults
  @@path     ||= File.expand_path(File.dirname(__FILE__) + '/../config.yml')
  @@defaults ||= YAML.load_file(@@path)

  class << self
    def name
      @@defaults[:default_user][:name]
    end

    def ambigious_name
      @@defaults[:default_user][:ambigous_name]
    end

    def not_existing_name
      @@defaults[:default_user][:not_existing_name]
    end

    def without_mobile_phone
      @@defaults[:default_user][:not_existing_name]
    end

    def number
      @@defaults[:default_user][:number]
    end

    def url
      @@defaults[:webservice][:url]
    end

    def username
      @@defaults[:webservice][:username]
    end

    def password
      @@defaults[:webservice][:password]
    end

    def birth_date
      @@defaults[:default_user][:birth_date]
    end
  end
end
