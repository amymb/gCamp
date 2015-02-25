require 'rails_helper'

describe User do
  before :each do
    @valid_attributes = {
      first_name: "Amy",
      last_name: "Bertken",
      email: "amy@test.com"
    }
  end
  
  it "validates user with first, last name, and email" do
    user = User.create(@valid_attributes)
    expect(user).to be_valid
  end

  it "is invalid when email is not unique" do
    User.create(@valid_attributes)
    user = User.create(first_name: "B", last_name: "C", email: "amy@test.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is invalid without a first name" do
    @valid_attributes.delete(:first_name)
    user = User.create(@valid_attributes)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last name" do
    @valid_attributes.delete(:last_name)
    user = User.create(@valid_attributes)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end
end
