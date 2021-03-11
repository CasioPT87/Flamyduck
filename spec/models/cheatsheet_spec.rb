require 'rails_helper'

RSpec.describe Cheatsheet, type: :model do
  subject do
    cheatsheets(:docker_compose)
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

  it 'has a name with empty string' do
    subject.name = ''
    subject.validate
    expect(subject.errors[:name]).to include("can't be blank", "is too short (minimum is 1 character)")
  end

  it 'has a name with more than 254 characters' do
    subject.name = ''
    255.times { subject.name << 'a'}
    subject.validate
    expect(subject.errors[:name]).to contain_exactly("is too long (maximum is 254 characters)")
  end
end
