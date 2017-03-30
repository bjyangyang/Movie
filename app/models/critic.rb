class Critic < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :content, presence: true
  
end
