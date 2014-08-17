class Account < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  
  validates :owner, presence: true
  validates :name, presence: true

  accepts_nested_attributes_for :owner
end
