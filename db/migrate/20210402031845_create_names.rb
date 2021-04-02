class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.integer :percent_off
      t.date :starts_on
      t.date :ends_on

      t.timestamps null: false
    end
  end
end
