class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors, id: false do |t|
      t.string :uid
      t.string :scname
      t.string :image

      t.timestamps null: false
    end
    add_index(:authors, :uid)
    execute "ALTER TABLE authors ADD PRIMARY KEY (uid);"
  end
end
