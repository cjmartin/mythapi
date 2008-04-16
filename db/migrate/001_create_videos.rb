class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.integer :height
      t.integer :width
      t.string :video_url
      t.string :file_name
      t.string :ext

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
