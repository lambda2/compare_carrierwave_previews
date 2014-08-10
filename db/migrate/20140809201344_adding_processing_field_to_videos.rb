class AddingProcessingFieldToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :video_processing, :boolean, default: false
    add_column :videos, :video_tmp, :string
  end
end
