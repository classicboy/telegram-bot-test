class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.references :question, foreign_key: true, index: true
      t.string :content
      t.integer :is_correct, limit: 1
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
