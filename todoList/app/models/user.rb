class User < ActiveRecord::Base
	has_and_belongs_to_many :tasks

    before_destroy { tasks.clear }

	 attr_reader :password

  def password=(unencrypted_password)
    unless unencrypted_password.empty?
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(unencrypted_password) 
    end
  end

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(self.password_digest) == unencrypted_password
      return self
    else
      return false
    end
  end

  validates :name, presence: true 
  validates :login_id, presence: true, uniqueness: {case_sensitive: false}, length: {in: 2..20}
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, confirmation: true, length: {in: 6..20}, on: :create


    private
  def format_user_input
    self.name = self.name.downcase.titleize
    self.email = self.email.downcase
    self.login_id = self.login_id.downcase
  end 

end
