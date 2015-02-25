require 'rails_helper'

describe Project do
  it "validates the presence of a name" do
    project = Project.create(name: nil)
    project.valid?
    expect(project.errors[:name]).to include("can't be blank")
  end
 end
