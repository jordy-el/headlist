class AddAttachmentPhotoToPosts < ActiveRecord::Migration[5.1]
  def self.up
    change_table :posts do |t|
      t.attachment :photo
      t.string :description
    end
  end

  def self.down
    remove_attachment :posts, :photo
    remove_column :posts, :description
  end
end
