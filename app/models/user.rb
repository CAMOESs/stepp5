class User < ApplicationRecord
    
    has_many :tasks, dependent: :destroy
    attr_accessor :password_confirmation
    has_secure_password
    validates :password_digest, presence: true
    #validates :password_confirmation, presence: true
    validates :name, 
        format:{with:/\A[a-zA-Z0-9_]{3,20}\z/},
        uniqueness: {case_sensitive: false}
        validates :email, 
        format:{with:/\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/},
        uniqueness: {case_sensitive: false}
    validates_length_of :password_digest, minimum: 6
    
end
