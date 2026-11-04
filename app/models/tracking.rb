class Tracking < ApplicationRecord
    validates :tracking_code, presence: true
    validates :tracking_code, uniqueness: { case_sensitive: false}

    has_many :histories, dependent: :destroy
end
