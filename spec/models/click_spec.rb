# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Click, type: :model do
  describe 'validations' do
    it 'validates url_id is valid' do
      should belong_to(:url)
    end

    it 'validates browser is not null' do
      should validate_presence_of(:browser)
    end

    it 'validates platform is not null' do
      should validate_presence_of(:platform)
    end
  end
end
