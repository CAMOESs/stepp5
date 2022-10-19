require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
    describe '登録機能' do
        context 'ラベルを登録した場合' do
            it '登録したラベルが表示される' do
               
                p = post 'http://localhost:3000/users', params: { user: {name: 'MyString1',email: "MyString@gmail.com" ,password_digest: "MyString",admin: false } }
               
                expect(response).to redirect_to tasks_path
                label = Label.create(name: 'label0' )
                label1 = Label.create(name: 'label1' )
                
                visit labels_path
                len = page.all('.XPl').length
                tab = []
                tab << label
                task_list = page.all('.XPl')
            end
        end
    end
    describe '一覧表示機能' do
        context '一覧画面に遷移した場合' do
        it '登録済みのラベル一覧が表示される' do
            p = post 'http://localhost:3000/users', params: { user: {name: 'MyString1',email: "MyString@gmail.com" ,password_digest: "MyString",admin: false } }
            label = Label.create(name: 'label0' )
            label1 = Label.create(name: 'label1' )
            response.code.should == "302"

        end
        end
    end
end