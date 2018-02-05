class Group < ApplicationRecord
  validates :name, presence: true
  has_many :usergroups
  has_many :users, through: :usergroups
  has_many :messages




end
