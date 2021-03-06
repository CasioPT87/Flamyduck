require 'rails_helper'

RSpec.describe User, type: :model do

  subject { User.new(name: 'sergio', password: 'Whatever11' )}

  it 'can save' do
    expect(subject).to be_valid
  end

  it 'needs a password with at least 6 characters including at least one number and one letter' do
    subject.password = 'onlyletters'
    expect(subject).not_to be_valid

    subject.password = '8787'
    expect(subject).not_to be_valid

    subject.password = 'short11'
    expect(subject).not_to be_valid
  end

  

end
