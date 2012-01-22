class Recipe < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :content
  validates_presence_of :user_id
end
