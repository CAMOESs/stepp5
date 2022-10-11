class User < ApplicationRecord
    #attr_accessible :password_confirmation
    attr_accessor :password_confirmation
    has_secure_password
    validates :name, 
        format:{with:/\A[a-zA-Z0-9_]{3,20}\z/},
        uniqueness: {case_sensitive: false}
        validates :email, 
        format:{with:/\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/},
        uniqueness: {case_sensitive: false}
    #validates :password_digest, presence: true, :confirmation =>true
    #validates_confirmation_of :password, if: :password.present?
   # validates_presence_of :password_confirmation, if: :password_changed?
    validates_length_of :password_digest, minimum: 6
end
