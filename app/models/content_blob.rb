class ContentBlob < ActiveRecord::Base
  attr_accessible :file

  def file=(file)
    self.data = file.read
  end
end
