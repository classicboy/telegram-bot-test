class CreateUserResults < ActiveRecord::Migration[5.2]
  def change
    create_table :user_results do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :is_perfect, limit: 1, default: 0 
      t.datetime :issued_date, index: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
