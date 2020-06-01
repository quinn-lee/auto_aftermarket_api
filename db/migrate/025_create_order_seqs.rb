class CreateOrderSeqs < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
	create sequence order_no_seq increment by 1 minvalue 1000000000 MAXVALUE 5000000000 start with 1000000000 CYCLE
    SQL
  end

  def down
    execute <<-SQL
	drop  sequence order_no_seq
    SQL
  end
end
