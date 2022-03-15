class Base < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # 画像の上限を100pxにする
  process resize_to_limit: [100, 100]

  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # jpg, jpeg, pngしか受け付けない
  def extension_white_list
    %w[jpg jpeg png]
  end

  def filename
    "#{secure_token}.png" if original_filename.present?
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
