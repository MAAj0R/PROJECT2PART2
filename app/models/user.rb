  class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  belongs_to :language

  enum role: [:guest, :moderator]

  before_save :default_values
  after_create :create_profile

  def default_values
  	self_role ||= 0
  	
  end
end
