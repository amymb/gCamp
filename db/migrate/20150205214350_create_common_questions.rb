class CreateCommonQuestions < ActiveRecord::Migration
  def change
    create_table :common_questions do |t|
      t.string :question
      t.string :answer

      t.timestamps null: false
    end
  end
end
