require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    # validation examples here
    it 'is valid with all parameters' do
      @user = User.new(first_name: 'Suraj', last_name: 'Nair', email: 'suraj@gmail.com', password: '123456', password_confirmation: '123456')
      expect(@user).to be_valid
    end

    it 'is not valid without email' do
      @user = User.new(first_name: 'Suraj', last_name: 'Nair', email: nil, password: '123456', password_confirmation: '123456')
      expect(@user).to_not be_valid
    end

    it 'is not valid without first name' do
      @user = User.new(first_name: nil, last_name: 'Nair', email: 'suraj@gmail.com', password: '123456', password_confirmation: '123456')
      expect(@user).to_not be_valid
    end

    it 'is not valid without last name' do
      @user = User.new(first_name: 'Suraj', last_name: nil, email: 'suraj@gmail.com', password: '123456', password_confirmation: '123456')
      expect(@user).to_not be_valid
    end

    it 'is not valid without password' do
      @user = User.new(first_name: 'Suraj', last_name: 'Nair', email: 'suraj@gmail.com', password: nil, password_confirmation: '123456')
      expect(@user).to_not be_valid
    end

    it 'is not valid without password_confirmation' do
      @user = User.new(first_name: 'Suraj', last_name: 'Nair', email: 'suraj@gmail.com', password: '123456', password_confirmation: nil)
      expect(@user).to_not be_valid
    end

    it 'is not valid if password and confirmation does not match' do
      @user = User.new(first_name: 'Suraj', last_name: 'Nair', email: 'suraj@gmail.com', password: '123456', password_confirmation: '654321')
      expect(@user).to_not be_valid
    end

    it 'is not valid if email is not unique (not case sensitive)' do
      @user1 = User.new(first_name: 'Suraj', last_name: 'Nair', email: 'suraj@gmail.com', password: '123456', password_confirmation: '123456')
      @user1.save
      @user2 = User.new(first_name: 'Suraj', last_name: 'Nair', email: 'SURAJ@gmail.com', password: '123456', password_confirmation: '123456')
      expect(@user2).to_not be_valid
      # error will say email has already been taken
    end

    it 'is not valid if the password does not have the minimum length' do
      @user = User.new(first_name: 'Suraj, last_name: 'Nair', email: 'suraj@gmail.com', password: '12345', password_confirmation: '12345')
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should return the user if authentication is sucessful' do
      @user = User.new(first_name: 'Suraj', last_name: 'Nair', email: 'suraj@gmail.com', password: '123456', password_confirmation: '123456')
      @user.save
      expect(User.authenticate_with_credentials('suraj@gmail.com', '123456')).to be == @user
    end

    it 'should return nil if authentication is unsucessful, password did not match' do
      @user = User.new(first_name: 'Suraj', last_name: 'Nair', email: 'suraj@gmail.com', password: '123456', password_confirmation: '123456')
      @user.save
      expect(User.authenticate_with_credentials('suraj@gmail.com', '654321')).to be_nil
    end

    it 'should return still be sucessful authentication with extra space entered with email' do
      @user = User.new(first_name: 'Suraj', last_name: 'Nair', email: 'suraj@gmail.com', password: '123456', password_confirmation: '123456')
      @user.save
      expect(User.authenticate_with_credentials(' suraj@gmail.com ', '123456')).to be == @user
    end

    it 'should return still be sucessful authentication with wrong case for email' do
      @user = User.new(first_name: 'Suraj', last_name: 'Nair', email: 'SUrAj@gmail.com', password: '123456', password_confirmation: '123456')
      @user.save
      expect(User.authenticate_with_credentials('SUrAj@gmail.com', '123456')).to be == @user
    end

  end

end