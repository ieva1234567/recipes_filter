class CreateDownloadExceptions < ActiveRecord::Migration[6.1]
  def change
    create_table :download_exceptions do |t|
      t.references :recipe, null: false, foreign_key: true
      t.text :exception_text

      t.timestamps
    end
  end
end
