class Movie < ApplicationRecord
  belongs_to :user
  has_many :critics
  validates :片名, presence: true
end
