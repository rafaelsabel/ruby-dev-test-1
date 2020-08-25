class Folder < ApplicationRecord
  has_many_attached :files
  has_many :subfolders, class_name: Folder.to_s, foreign_key: 'top_folder_id'

  belongs_to :top_folder, class_name: Folder.to_s, optional: true

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false, scope: :top_folder_id }
  validates :top_folder, presence: true, if: proc { |folder| folder.top_folder_id.present? }
end
