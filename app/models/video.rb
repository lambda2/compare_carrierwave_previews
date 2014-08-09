class Video < ActiveRecord::Base
  mount_uploader :video, VideoUploader


  def set_success(format, opts)
    puts "Longue vie au roi ! \n#{format}, \n#{opts}"
    # Si on veut mettre un petit flag...
    # self.success = true
  end

end
