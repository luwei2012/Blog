class Role < ActiveRecord::Base
  has_many :users, :dependent => :nullify
  validates :role_name, uniqueness: true, presence: true
end
