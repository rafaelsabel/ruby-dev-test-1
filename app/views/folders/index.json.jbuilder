json.array!(@folders) do |folder|
  json.extract!(folder, :id, :name, :top_folder_id, :created_at, :updated_at)
  json.url folder_url(folder, format: :json)
end
