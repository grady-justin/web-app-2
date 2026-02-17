class Contact < ApplicationRecord
  belongs_to :company
  # connects to contacts table
  validates :company_id, presence: true
end
