require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    context 'ユーザの名前が空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.new(name: '',email: "MyString@gmail.com" ,password_digest: "MyString",admin: false )
        user.validate
        expect(user).not_to be_valid
      end

    end

    context 'ユーザのメールアドレスが空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.new(name: 'MyString',email: "" ,password_digest: "MyString",admin: false )
        user.validate
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのパスワードが空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.new(name: 'MyString',email: "MyString@gmail.com" ,password_digest: "",admin: false )
        user.validate
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのメールアドレスがすでに使用されていた場合' do
      it 'バリデーションに失敗する' do
        user2 = User.create(name: 'MyString2',email: "MyString@gmail.com" ,password_digest: "MyString",admin: false )
        user = User.new(name: 'MyString1',email: "MyString@gmail.com" ,password_digest: "MyString",admin: false )
        user.validate
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのパスワードが6文字未満の場合' do
      it 'バリデーションに失敗する' do
        user = User.new(name: 'MyString1',email: "MyString@gmail.com" ,password_digest: "MyS",admin: false )
        user.validate
        expect(user).not_to be_valid
      end
    end

    context 'ユーザの名前に値があり、メールアドレスが使われていない値で、かつパスワードが6文字以上の場合' do
      it 'バリデーションに成功する' do
        user = User.new(name: 'MyString1',email: "MyString@gmail.com" ,password_digest: "MyString",admin: false )
        user.validate
        expect(user).to be_valid
      end
    end
  end
end
