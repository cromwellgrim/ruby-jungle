require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do

    it "needs password and password confirmation to match" do
      user = User.new(email: "example@mail.com", name: "Test", password: "1234", password_confirmation: "1234")
      expect(user.password).to eql(user.password_confirmation)
      user2 = User.new(email: "example2@mail.com", name: "Test2", password: "12345", password_confirmation: "1234")
      expect(user2.password).to_not eql(user2.password_confirmation)
    end
    
    it "needs the password to be a minimum of 4 characters" do
      user = User.create(email: "example3@mail.com", name: "Test", password: "1234", password_confirmation: "1234")
      expect(user).to be_valid
      user2 = User.create(email: "eXample4@mail.com", name: "Test2", password: "123", password_confirmation: "123")
      expect(user2).to_not be_valid
    end
  
    it "needs the email to be unique" do
      user = User.create(email: "example5@mail.com", name: "Test", password: "1234", password_confirmation: "1234")
      expect(user).to be_valid
      user2 = User.create(email: "eXample5@mail.com", name: "Test2", password: "1234", password_confirmation: "1234")
      expect(user2).to_not be_valid
    end
    
    it "needs email and name" do
      user = User.create(email: "", name: "Test", password: "1234", password_confirmation: "1234")
      expect(user).to_not be_valid
      user2 = User.create(email: "eXample6@mail.com", name: "", password: "1234", password_confirmation: "1234")
      expect(user2).to_not be_valid 
      user3 = User.create(email: "eXample7@mail.com", name: "tester", password: "1234", password_confirmation: "1234")
      expect(user3).to be_valid 
    end

  end

  describe '.authenticate_with_credentials' do

    before do
      @user = User.create(
        email: "example@mail.com",
        name: "Tester",
        password: "1234",
        password_confirmation: "1234"
      )
    end

    it "should login you in with correct credentials" do
      user = User.authenticate_with_credentials("example@mail.com", "1234")
      expect(user).to_not be(nil)
    end

    it "not allow login with incorrect credentials" do
      user = User.authenticate_with_credentials("example@mail.com", "12345")
      expect(user).to be(nil)
    end

    it "should login a user with spaces around their email" do
      user = User.authenticate_with_credentials(" example@mail.com ", "1234")
      expect(user).to_not be(nil)
    end

    it "should login a user with mixed case in their email" do
      user = User.authenticate_with_credentials("eXampLe@mail.com", "1234")
      expect(user).to_not be(nil)
    end
  end
end
