require 'rails_helper'

describe Task do
  it "validates the presence of a description" do
    task = Task.create(description:nil)
    task.valid?
    expect(task.errors[:description]).to include("can't be blank")
  end
end
