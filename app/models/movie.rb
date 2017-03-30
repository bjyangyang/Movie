class Movie < ApplicationRecord
  belongs_to :user
  validates :片名, presence: true
end
