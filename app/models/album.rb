class Album < ActiveRecord::Base
  belongs_to :user
  has_many :articles, :dependent => :destroy
  validates :album_name, presence: true, uniqueness: true


end
