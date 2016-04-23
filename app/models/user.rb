class User < ActiveRecord::Base
  has_secure_password

  belongs_to :role

  has_many :albums, :dependent => :destroy
  has_many :articles, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  has_many :user_article_collections, :dependent => :destroy
  has_many :collected_articles, class_name: "Article", :through => :user_article_collections
  has_many :user_article_praises, :dependent => :destroy
  has_many :praised_articles, class_name: "Article", :through => :user_article_praises
  has_many :user_comment_praises, :dependent => :destroy
  has_many :praised_comments, class_name: "Comment", :through => :user_comment_praises

  has_one :user_icon, :dependent => :destroy

  validates :account, format: {with: /\A[1][358][0-9]{9}\z/, message: '请输入正确的手机号'}, uniqueness: true
  validates :user_name, uniqueness: true
  validates :email, format: {with: /\A\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\z/, message: '请输入有效邮箱'}
  validates :account, :user_name, :email, presence: true
  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = random_intCode
    end while User.exists?(column => self[column])
  end

  def send_password_reset(request)
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.user_password_reset(self).deliver
  end

  def total_words

  end

end
