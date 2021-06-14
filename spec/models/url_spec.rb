# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it 'validates original URL is a valid URL' do
      should allow_value('http://github.com')
        .for(:original_url)
        .on(:create)
    end

    it 'validates short URL is present' do
      should validate_presence_of :short_url
    end
  end
end
