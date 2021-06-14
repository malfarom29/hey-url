# frozen_string_literal: true

class Click < ApplicationRecord
  belongs_to :url
  counter_culture :url
end
