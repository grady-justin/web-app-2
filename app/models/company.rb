class Company < ApplicationRecord
  has_many :contacts
  # connects to companies table
  validates :name, presence: true, uniqueness: true
end
