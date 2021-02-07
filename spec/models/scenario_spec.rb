require 'rails_helper'

RSpec.describe Scenario, type: :model do

  subject do
    cheatsheet = Cheatsheet.new(name: 'my cheatsheet')
    described_class.new(name: 'my scenario', cheatsheet: cheatsheet)
  end

  describe 'Associations' do

    it 'should belong to cheatsheet' do
      association = described_class.reflect_on_association(:cheatsheet)
      expect(association.macro).to eq(:belongs_to)
    end
  end
  
  it 'is not valid without a cheatsheet' do
    subject.cheatsheet = nil
    expect(subject.validate).to be(false)
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject.validate).to be(false)
  end

end
