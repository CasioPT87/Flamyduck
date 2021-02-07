require 'rails_helper'

RSpec.describe Cheatsheet, type: :model do
  subject do
    user = User.new(name: 'user 1', password: 'password')
    described_class.new(name: 'my cheat sheet', user: user)
  end

  describe 'Associations' do

    it 'should belong to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
  
  it 'is not valid without a user' do
    subject.user = nil
    expect(subject.validate).to be(false)
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject.validate).to be(false)
  end
end
