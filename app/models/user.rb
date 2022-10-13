class User < ApplicationRecord
    
    has_many :tasks
    attr_accessor :password_confirmation
    has_secure_password
    validates :password_digest, confirmation: true, presence: true
    #validates :password_digest_confirmation, presence: true
    validates :name, 
        format:{with:/\A[a-zA-Z0-9_]{3,20}\z/},
        uniqueness: {case_sensitive: false}
        validates :email, 
        format:{with:/\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/},
        uniqueness: {case_sensitive: false}
    validates_length_of :password_digest, minimum: 6
    #validate :lastAdmin
    #validate :vide

    private
        #def lastAdmin
        #    if session[:h] == 1 && User.all.where(admin: :true).count == 2
        #        errors.add(:admin,"just two admin")
        #    end
        #end
        #def vide
        #    if password_confirmation.length == 0
        #        errors.add(:password,"just two admin")
        #   end
        #end

end
