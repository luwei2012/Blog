class Article < ActiveRecord::Base
  belongs_to :album
  belongs_to :user

  has_many :documents, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  has_many :user_article_collections
  has_many :collected_users, class_name: "User", :through => :user_article_collections
  has_many :user_article_praises
  has_many :praised_users, class_name: "User", :through => :user_article_praises

  validates :title, presence: true
  validates :words_count, numericality: {only_integer: true, greater_than: 0}


  before_create :add_words_count
  before_update :update_words_count
  before_destroy :remove_words_count

  def add_words_count
    self.album.words_count += self.words_count
  end

  def update_words_count
    self.album.words_count = self.words_count - Article.find_by_id(self.id).words_count
  end

  def remove_words_count
    self.album.words_count -= self.words_count
  end

end
