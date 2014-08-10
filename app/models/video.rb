class Video < ActiveRecord::Base
  mount_uploader :video, VideoUploader
  process_in_background :video
  store_in_background :video


  def set_success(format, opts)
    puts "Longue vie au roi ! \n#{format}, \n#{opts}"
    # Si on veut mettre un petit flag...
    # self.success = true
  end

end
