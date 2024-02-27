class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email

      t.text :private_api_key_ciphertext
      
      t.string :private_api_key_bidx
      t.index :private_api_key_bidx, unique: true

      t.timestamps
    end
  end
end
