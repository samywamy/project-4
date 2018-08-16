class CreateQuestionsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :questions_users do |t|
      t.references :question, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
