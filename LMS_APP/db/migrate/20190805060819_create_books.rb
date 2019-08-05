class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name, unique: true
      t.string :status
      t.string :content
      t.integer :pages, default: 0
      t.integer :number_of, default: 0
      t.references :author, foreign_key: true
      t.references :category, foreign_key: true
      t.references :publisher, foreign_key: true

      t.timestamps
    end
  end
end
