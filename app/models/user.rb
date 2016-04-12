class User < ActiveRecord::Base

	attr_accessor :remember_token

	# Converting email to downcase before save
	before_save { self.email = email.downcase }

	#Validates Name
	validates :name, presence: true, length: { maximum: 50 }

	# Definiing email regex
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	# Valdating email with regex
	validates :email, presence: true, length: { maximum: 255 },
			format: { with: VALID_EMAIL_REGEX },
			uniqueness: { case_sensitive: false }

	# Hashed Password
	has_secure_password

	# validates password
	validates :password, length: { minimum: 6 }


	# Returns hash of string

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
															Bcrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end


	# Return a random token
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Remember user for data persistence
	def remember
		self.remember_token = User.new_token
		update_attributes(:remember_digest, User.digest(remember_token))
	end

	# Return true if the token matches the digest
	def authenticated?(remember_token)
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Forget a user
	def forget
		update_attributes(:remember_digest, nil)
	end
end
