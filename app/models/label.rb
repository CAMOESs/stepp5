class Label < ApplicationRecord
    paginates_per 10
    has_and_belongs_to_many :tasks
    belongs_to :user
    validates :name, presence: true, uniqueness: {case_sensitive: false}
end
