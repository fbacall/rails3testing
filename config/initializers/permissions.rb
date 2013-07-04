require 'yaml'

class Permissions

  @permissions = YAML::load_file("config/permissions.yml")
  @permissions.symbolize_keys!.each_value {|v| v.symbolize_keys!}

  def self.roles(object_type, action)
    unless @permissions[object_type].nil?
      @permissions[object_type][action]
    else
      nil
    end
  end

end
