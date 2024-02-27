class CreateSiteIdentifiers < ActiveRecord::Migration[6.1]
  def change
    create_table :site_identifiers do |t|
      t.string :title
      t.string :identifier

      t.timestamps
    end
  end
end
