require 'rails_helper'

RSpec.describe Article, type: :model do
  subject do
    described_class.new(title: 'Article test',
                        body: 'new article test',
                        status: 'public',
                        user_id: 1)
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a body' do
      subject.body = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a body that has less than 10 characters' do
      subject.body = 'test'
      expect(subject).to_not be_valid
    end

    it 'is not valid without a status' do
      subject.status = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a user_id' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end
  end
end
