class User < ActiveRecord::Base
    has_secure_password
    
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: { case_sensitive: false}
    validates :password, length: { minimum: 6 }
    validates :password, confirmation: true
    validates :password_confirmation, presence: true

    before_save :downcase_email

    def downcase_email
      self.email.downcase!
    end

    def self.authenticate_with_credentials(email, password)
      user = User.find_by(email: email.strip.downcase)&.authenticate(password)
      if user
        return user
      else 
        return nil
      end
    end

  end