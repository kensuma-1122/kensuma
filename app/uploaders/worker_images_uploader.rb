class WorkerImagesUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # 画像の上限を100pxにする
  process resize_to_limit: [100, 100]
  
  # 使用するストレージの種類
  storage :file

  # アップロードされたファイルが保存されるディレクトリを上書き
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 許可する拡張子
  def extension_allowlist
    %w(jpg jpeg gif png)
  end
end
