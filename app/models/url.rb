# frozen_string_literal: true

class Url < ApplicationRecord
  # scope :latest, -> {}
  has_many :clicks

  validates_format_of :original_url, 
                      with: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
                      multiline: true

  validates :original_url, :short_url, presence: true
end
