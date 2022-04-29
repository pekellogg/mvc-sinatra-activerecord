class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, index: {unique: true}
      # t.string :email # 1
      # t.index :email, unique: true # 1
      t.string :email, index: {unique: true}
      # t.string :email, :null => false
      t.string :password_digest
    end
  end
end
