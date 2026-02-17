class Company < ApplicationRecord
  # connects to companies table
  validates :name, presence: true, uniqueness: true
end
