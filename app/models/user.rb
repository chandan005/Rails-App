class User < ActiveRecord::Base

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
end
