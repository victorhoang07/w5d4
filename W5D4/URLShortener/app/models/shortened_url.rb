class ShortenedUrl < ApplicationRecord
    validates :short_url, presence: true, uniqueness: true 
    validates :user_id, :long_url, presence: true

    def self.random_code 
        SecureRandom::urlsafe_base64 
    end

    def self.insert_short_url(user, long_url)
        ShortenedUrl.create!(
            user_id: user.id, 
            long_url: long_url, 
            short_url: ShortenedUrl.random_code)
    end

    belongs_to :submitter, 
        primary_key: :id, 
        foreign_key: :user_id, 
        class_name: :User

    has_many :visitors,
        primary_key: :id, 
        foreign_key: :url_id,
        class_name: :Visit

    def num_clicks 
        visitors.count 
    end

    def num_uniques
        visitors.map {|visitor| visitor.id}.uniq.count 
    end

    def num_recent_uniques
        visitors.select {|v| v.created_at > 10.minutes.ago}.count 
    end 
end
