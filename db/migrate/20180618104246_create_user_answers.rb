class CreateUserAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_answers do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :answer_id
      t.datetime :issued_date
      t.datetime :deleted_at, index: true

      t.timestamps
    end
    add_index :user_answers, :issued_date
  end
end
