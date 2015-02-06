class ChangeStringToText < ActiveRecord::Migration
  def change
    change_column :common_questions, :question, :text
    change_column :common_questions, :answer, :text
  end
end
