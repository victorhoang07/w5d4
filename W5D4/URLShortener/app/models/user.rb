class User < ApplicationRecord 

    validates :email, uniqueness: true, presence: true 
    validate :valid_email?

    has_many :submitted_urls,
        primary_key: :id,
        foreign_key: :user_id, 
        class_name: :ShortenedUrl

    has_many :visited_urls,
        primary_key: :id, 
        foreign_key: :user_id, 
        class_name: :Visit 
end
