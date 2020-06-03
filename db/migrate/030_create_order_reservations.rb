class CreateOrderReservations < ActiveRecord::Migration[5.1]
  def self.up
    create_table :order_reservations do |t|
      t.integer :shop_id
      t.string :order_no
      t.date :booking_date
      t.datetime :booking_time_from
      t.datetime :booking_time_to
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :order_reservations
  end
end
