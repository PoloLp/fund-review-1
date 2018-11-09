class CreateFunds < ActiveRecord::Migration[5.2]
  def change
    create_table :funds do |t|
      t.string :securityname
      t.string :isin
      t.string :secid
      t.string :performanceid
      t.string :fundid
      t.string :company
      t.timestamps
    end
  end
end
