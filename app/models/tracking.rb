class Tracking < ApplicationRecord
    validates :tracking_code, uniqueness: { case_sensitive: false}

    has_many :histories
end
