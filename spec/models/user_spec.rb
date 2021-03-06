require 'rails_helper'

RSpec.describe User, type: :model do

  context 'Name and Password validation' do

    subject { User.new(name: 'sergio', password: 'Whatever11' )}

    it 'can save' do
      expect(subject).to be_valid
    end

    it 'needs a name between 3 and 15 characters' do
      subject.name = 'Eo'
      expect(subject).not_to be_valid

      subject.name = 'JesusMarianoLopezThisIsTooLong'
      expect(subject).not_to be_valid

      subject.name = 'Joselin'
      expect(subject).to be_valid
    end

    it 'needs a password between 6 and 15 characters including at least one number, one uppercase and one lowercase letter' do
      subject.password = 'Onlyletters'
      expect(subject).not_to be_valid

      subject.password = '8787'
      expect(subject).not_to be_valid

      subject.password = 'alllowercase11'
      expect(subject).not_to be_valid

      subject.password = 'ALLUPPERCASE11'
      expect(subject).not_to be_valid

      subject.password = 'Shrt1'
      expect(subject).not_to be_valid

      subject.password = 'Toolong1Toolong1Toolong1'
      expect(subject).not_to be_valid

      subject.password = 'Whatever11'
      expect(subject).to be_valid
    end
  end

  context 'Associations' do
    it 'has many Groups' do
      association = described_class.reflect_on_association(:groups)
      expect(association.macro).to eq(:has_and_belongs_to_many)
    end

    it 'has many Cheatsheets' do
      association = described_class.reflect_on_association(:cheatsheets)
      expect(association.macro).to eq(:has_many)
    end
  end
end
