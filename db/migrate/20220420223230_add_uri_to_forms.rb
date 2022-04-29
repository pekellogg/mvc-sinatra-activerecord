class AddUriToForms < ActiveRecord::Migration[6.0]
  def change
    add_column :forms, :uri, :string
  end
end
