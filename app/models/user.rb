class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
	# validates :name, presence: true
	has_many :addresses
	has_many :friend_ships
	has_many :posts
	has_many :comments
	has_one :like

	has_many :messagee, foreign_key: :sender_id, class_name: 'Chat'  
  has_many :senders, through: :messagee
  has_many :messaged, foreign_key: :group_id, class_name: 'Chat'
  has_many :groups, through: :messaged

	accepts_nested_attributes_for :addresses
	
	validates :name, :presence => {:message => "can't be blank." }
	validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :password, :length => {:within => 6..20}
	
	scope :all_except, ->(user) { where.not(id: user) }

	def self.from_omniauth(access_token)
	  data = access_token.info
	  user = User.where(:email => data["email"]).first

	  unless user
	    password = Devise.friendly_token[0,20]
	    user = User.create(name: data["name"], email: data["email"],
	      password: password, password_confirmation: password
	    )
	  end
	  user
	end


end
