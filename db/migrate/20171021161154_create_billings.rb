class CreateBillings < ActiveRecord::Migration[5.0]
  def change
    create_table :billings do |t|
      t.integer :event_id
      t.string :location
      t.datetime :date
      t.float :total_amount
      t.integer :billed_by
      t.timestamps
    end
  end
end
