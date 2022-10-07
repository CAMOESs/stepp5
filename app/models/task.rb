class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validates :priority, presence: true
    validates :deadline_on, presence: true
    validates :status, presence: true
    paginates_per 10
    enum priority: { 高:0, 中:1, 低:2 }
    enum status: {未着手:0, 着手中:1, 完了:2}
    
end