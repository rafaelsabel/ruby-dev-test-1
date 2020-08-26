class CreateFolders < ActiveRecord::Migration[6.0]
  def change
    create_table :folders do |t|
      t.string :name, null: false, limit: 100
      t.references :top_folder, index: true, foreign_key: { to_table: :folders, on_delete: :cascade }

      t.timestamps
    end
  end
end
