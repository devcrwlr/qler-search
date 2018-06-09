class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 validates :username, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: true }, format: { with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }

 def email_required?
      false
  end
end
