class Contact < ApplicationRecord
  # connects to contacts table
  validates :company_id, presence: true
end
