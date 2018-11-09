class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :structure
      t.text :current
      t.references :fund, foreign_key: true

      t.timestamps
    end
  end
end
