json.extract!(@folder, :id, :name, :top_folder_id, :created_at, :updated_at)
json.url folder_url(@folder, format: :json)

json.subfolders do
  json.array!(@folder.subfolders) do |subfolder|
    json.extract!(subfolder, :id, :name, :top_folder_id, :created_at, :updated_at)
    json.url folder_url(subfolder, format: :json)
  end
end

json.files do
  json.array!(@folder.files) do |file|
    json.extract!(file, :id, :filename, :content_type, :byte_size, :created_at)
    json.preview_url rails_blob_url(file)
    json.download_url rails_blob_url(file, disposition: :attachment)
  end
end
