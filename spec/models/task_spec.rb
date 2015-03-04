require 'rails_helper'

describe Task do
  it "validates tasks with a description" do
    task = Task.create(description: "Sweet Task")
    expect(task).to be_valid
  end

  it "is invalid without a description" do
    task = Task.create(description:nil)
    task.valid?
    expect(task.errors[:description]).to include("can't be blank")
  end
end
