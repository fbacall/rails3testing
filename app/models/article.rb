class Article < ActiveRecord::Base
  attr_accessible :author_id, :body, :title

  belongs_to :author, :class_name => "User"
end
