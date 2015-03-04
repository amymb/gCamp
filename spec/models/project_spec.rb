require 'rails_helper'

describe Project do
  it "declares projects with no name invalid" do
    project = Project.create(name: nil)
    project.valid?
    expect(project.errors[:name]).to include("can't be blank")
  end

  it "validates projects with a name" do
    project = Project.create(name: "great project")
    expect(project).to be_valid
  end

 end
