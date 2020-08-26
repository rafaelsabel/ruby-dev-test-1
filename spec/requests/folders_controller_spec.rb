require 'rails_helper'

RSpec.describe FoldersController do
  describe 'get /folders' do
    let!(:folder) { create(:folder) }
    let!(:subfolder) { create(:folder, top_folder_id: folder.id) }

    subject { get '/folders.json', params: params }
    let(:params) { nil }

    context 'root folders' do
      it 'returns a JSON response' do
        subject
        expect(JSON.parse(response.body).last['id']).to eql(folder.id)
      end

      it 'returns status success' do
        subject
        expect(response).to have_http_status :success
      end
    end

    context 'all folders' do
      let(:params) { { all: true } }

      it 'returns a JSON response' do
        subject
        expect(JSON.parse(response.body).last['id']).to eql(subfolder.id)
      end

      it 'returns status success' do
        subject
        expect(response).to have_http_status :success
      end
    end
  end

  describe 'POST /folders' do
    subject { post '/folders.json', params: params }

    let(:params) { { folder: { name: name, top_folder_id: top_folder_id } } }
    let(:name) { Faker::Name.middle_name }
    let(:top_folder_id) { nil }

    context 'valid request' do
      it 'returns status created' do
        subject
        expect(response).to have_http_status :created
      end

      it 'creates a folder' do
        expect { subject }.to change { Folder.count }.from(0).to(1)
      end
    end

    context 'invalid request' do
      let(:name) { nil }

      it 'returns status unprocessable entity' do
        subject
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns a JSON response' do
        subject
        expect(JSON.parse(response.body)).to eql('name' => ['can\'t be blank'])
      end

      it 'does not create a folder' do
        expect { subject }.not_to change { Folder.count }.from(0)
      end
    end
  end

  describe 'DELETE /folders/:id.json' do
    let!(:folder) { create(:folder) }

    subject { delete "/folders/#{folder.id}.json" }

    context 'valid request' do
      it 'returns no content' do
        subject
        expect(response).to have_http_status :success
      end
    end
  end
end
