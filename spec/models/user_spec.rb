require 'rails_helper'

describe User do
  it "validates user with first, last name, and email" do
    user = User.create(first_name: "Amy", last_name: "Bertken", email: "amy@test.com")
    expect(user).to be_valid
  end

  it "is invalid when email is not unique" do
    User.create(first_name: "J", last_name: "B", email: "j@test.com")
    user = User.create(first_name: "B", last_name: "C", email: "j@test.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is invalid without a first name" do
    user = User.create(first_name: nil, last_name: "b", email: "b@test.com")
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last name" do
    user = User.create(first_name: "b", last_name: nil, email: "b@test.com")
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end
end
