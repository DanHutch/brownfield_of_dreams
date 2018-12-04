class CreateApiKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :apikeys do |t|
      t.integer :host
      t.string :key
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
