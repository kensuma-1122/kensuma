class RenameTypeColumnToDocuments < ActiveRecord::Migration[6.1]
  def change
    rename_column :documents, :type, :document_type
  end
end
