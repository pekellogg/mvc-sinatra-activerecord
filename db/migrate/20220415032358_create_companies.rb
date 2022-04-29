class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.integer :cik
      t.string :ticker
      t.string :title
    end
  end
end
