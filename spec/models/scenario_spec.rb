require 'rails_helper'

RSpec.describe Scenario, type: :model do

  subject do
    scenarios(:bash)
  end

  describe 'Associations' do

    it 'should belong to cheatsheet' do
      association = described_class.reflect_on_association(:cheatsheet)
      expect(association.macro).to eq(:belongs_to)
    end
  end
  
  it 'is not valid without a cheatsheet' do
    debugger
    subject.cheatsheet = nil
    expect(subject.validate).to be(false)
  end

  it 'is not valid without a content' do
    subject.content = nil
    expect(subject.validate).to be(false)
  end

  it 'has a content with empty string' do
    subject.content = ''
    subject.validate
    expect(subject.errors[:content]).to include("can't be blank", "is too short (minimum is 1 character)")
  end

  it 'has a content with more than 50 characters' do
    subject.content = ''
    51.times { subject.content << 'a'}
    subject.validate
    expect(subject.errors[:content]).to contain_exactly("is too long (maximum is 50 characters)")
  end
end
