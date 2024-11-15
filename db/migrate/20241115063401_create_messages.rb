class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.references :ticket, null: false, foreign_key: true
      t.string :sender
      t.text :content

      t.timestamps
    end
  end
end
