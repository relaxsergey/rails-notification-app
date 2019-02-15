class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :subscribe_token
      t.string :server_name

      t.timestamps
    end
  end
end
