class CreateForms < ActiveRecord::Migration[6.0]
  def change
    create_table :forms do |t|
      t.integer :cik
      t.string :accession_number
      t.string :report_date
      t.string :doc
      t.string :doc_description
    end
  end
end
