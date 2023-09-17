class RenameTypeToPackageType < ActiveRecord::Migration[7.0]
  def change
    rename_column :packages, :type, :package_type
  end
end
