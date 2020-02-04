class CreateBeerTable < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :brewery
      t.integer :abv
      t.string :style
      t.string :notes
      t.integer :uscore
      t.integer :bascore
      t.string :img
    end
  end
end
