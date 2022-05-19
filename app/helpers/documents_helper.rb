module DocumentsHelper
  # 書類の見出し番号
  def worker_number(worker)
    worker[1] + 1 unless worker.nil?
  end

  # contentの作業員jsonデータ workerモデルの表示
  def worker_column(column, worker)
    JSON.parse(worker[0])[column] unless worker.nil?
  end

  # contentの作業員jsonデータ workerモデルに紐づくモデルの表示
  def worker_attribute_column(model, column, worker)
    JSON.parse(worker[0])[model][column] unless worker.nil?
  end

  # contentの作業員jsonデータ workerモデルに紐づくモデル(has_many)の表示
  def worker_attributes_column(model, column, worker)
    JSON.parse(worker[0])[model].map { |value| value[column] } unless worker.nil?
  end
end
