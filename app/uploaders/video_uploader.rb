# encoding: utf-8

class VideoUploader < CarrierWave::Uploader::Base

  include ::CarrierWave::Backgrounder::Delay
  include CarrierWave::Video  # for your video processing
  include CarrierWave::Video::Thumbnailer

  process encode_video: [:mp4, callbacks: { after_transcode: :set_success } ]
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  (0..100).step(10).each do |progress|
    version "thumb_#{progress}".to_sym do
      process thumbnail: [{format: 'png', seek: "#{progress}%", quality: 10, size: 192, strip: true, logger: Rails.logger}]
      def full_filename for_file
        png_name for_file, version_name
      end
    end
  end

  version :low_d do
    process encode_video: [:mp4, callbacks: { after_transcode: :set_success }, resolution: "720×480"]
    def full_filename for_file
      %Q{#{version_name}_#{for_file}}
    end
  end

  # version :gif do
  #   process encode_video: [:gif, :custom => ' -vf scale=320:-1 -t 10 -r 10']
  #   def full_filename for_file
  #     %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.gif}
  #   end
  # end

  def png_name for_file, version_name
    %Q{#{for_file.chomp(File.extname(for_file))}_s#{version_name}.png}
  end

  # Petit helper pour avoir l'url du thumbnail
  def thumb_url
    "#{store_dir}/#{png_name @file.filename, 'thumb_0'}"
  end
end
