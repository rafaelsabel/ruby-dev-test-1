require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(100) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:top_folder).optional(true) }
    it { is_expected.to have_many(:subfolders) }
  end

  context 'when valid folder' do
    let(:top_folder) { build(:folder) }
    let(:subfolder) { build(:folder, top_folder: top_folder) }

    it 'creating a valid root folder' do
      expect(top_folder).to be_valid
    end

    it 'creating a valid subfolder' do
      expect(subfolder).to be_valid
    end
  end

  context 'when invalid folder' do
    let(:top_folder) { build(:folder, name: nil) }
    let(:subfolder) { build(:folder, top_folder_id: -1) }
    let!(:folder) { create(:folder, name: 'root') }

    it 'without name' do
      expect(top_folder).to be_invalid
    end

    it 'invalid top folder' do
      expect(subfolder).to be_invalid
    end

    it 'with same name' do
      expect(build(:folder, name: 'root')).to be_invalid
    end
  end
end
