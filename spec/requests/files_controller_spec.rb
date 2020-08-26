require 'rails_helper'

RSpec.describe FilesController do
  describe 'POST /folders/:folder_id/files.json' do
    let!(:folder) { create(:folder) }
    let(:file) { fixture_file_upload('rspec.png') }

    subject { post "/folders/#{folder.id}/files.json", params: { folder: { files: [file] } } }

    context 'valid request' do
      it 'returns status created' do
        subject
        expect(response).to have_http_status :created
      end

      it 'creates a blob ' do
        expect { subject }.to change { ActiveStorage::Blob.count }.from(0).to(1)
      end
    end
  end

  describe 'DELETE /folders/:folder_id/files/:id.json' do
    let!(:folder) { create(:folder) }
    let(:file) { fixture_file_upload('rspec.png') }

    subject {
      post "/folders/#{folder.id}/files.json", params: { folder: { files: [file] } }
      delete "/folders/#{folder.id}/files/#{folder.files.last.id}.json"
    }

    context 'valid request' do
      it 'returns no content' do
        subject
        expect(response).to have_http_status :success
      end
    end
  end
end
