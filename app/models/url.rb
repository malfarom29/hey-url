# frozen_string_literal: true

class Url < ApplicationRecord
  # scope :latest, -> {}
  has_many :clicks
end
