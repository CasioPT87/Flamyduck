require 'rails_helper'

RSpec.describe Group, type: :model do
  subject do
    user = Group.new(name: 'user1')
    described_class.new(name: 'my group', creator: user)
  end

  describe 'Associations' do

    it 'should belong to creator' do
      association = described_class.reflect_on_association(:creator)
      expect(association.macro).to eq(:belongs_to)
    end
  end
  

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject.validate).to be(false)
  end

  it 'has a name with empty string' do
    subject.name = ''
    subject.validate
    expect(subject.errors[:name]).to contain_exactly("can't be blank", "is too short (minimum is 3 characters)")
  end

  it 'has a name with more than 30 characters' do
    subject.name = ''
    51.times { subject.name << 'a'}
    subject.validate
    expect(subject.errors[:name]).to contain_exactly("is too long (maximum is 30 characters)")
  end
end
