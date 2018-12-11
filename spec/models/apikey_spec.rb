require 'rails_helper'

RSpec.describe Apikey, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:host)}
    it {should validate_presence_of(:key)}
    it {should validate_presence_of(:uid)}
    it {should belong_to(:user)}
  end

end
