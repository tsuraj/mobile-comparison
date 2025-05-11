class Mobile < ApplicationRecord
    validates :model, presence: true
    validates :model, uniqueness: true
end
