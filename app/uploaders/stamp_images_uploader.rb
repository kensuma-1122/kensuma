class StampImagesUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # 画像の上限を700pxにする
  process resize_to_limit: [100, 100]

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # jpg,jpeg,gif,pngしか受け付けない
  def extension_white_list
    %w[jpg jpeg gif png]
  end
end
