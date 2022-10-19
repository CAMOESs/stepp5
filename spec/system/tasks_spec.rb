require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
    before do
        u =User.create(id:1,name: :hype, email: "hype@gmail.com", password_digest: 123456, admin: true)
    end

    describe '一覧表示機能' do
        context '一覧画面に遷移した場合' do
           
            it '登録済みのタスク一覧が表示される' do
                # テストで使用するためのタスクを登録
                # タスク一覧画面に遷移
                task = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.new, priority: 2, status: 1, user_id: 1)

                visit tasks_path
                # visit（遷移）したpage（この場合、タスク一覧画面）に"書類作成"という文字列が、have_content（含まれていること）をexpect（確認・期待）する
                expect(task.errors.messages).to eq ({})
                # expectの結果が「真」であれば成功、「偽」であれば失敗としてテスト結果が出力される
            end
        end
    end

    describe '登録機能' do
        context 'タスクを登録した場合' do
            it '登録したタスクが表示される' do
                # テストで使用するためのタスクを登録
                # タスク一覧画面に遷移
                task = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.new, priority: 2, status: 1, user_id: 1)

                visit root_path
                # visit（遷移）したpage（この場合、タスク一覧画面）に"書類作成"という文字列が、have_content（含まれていること）をexpect（確認・期待）する
                expect(task.errors.messages).to eq ({})                # expectの結果が「真」であれば成功、「偽」であれば失敗としてテスト結果が出力される
            end
        end
    end

    describe '詳細表示機能' do
        context '任意のタスク詳細画面に遷移した場合' do
            it 'そのタスクの内容が表示される' do
                # テストで使用するためのタスクを登録
                task = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.new, priority: 2, status: 1, user_id: 1)

                # タスク一覧画面に遷移
                #visit task_path(task.id)
                # visit（遷移）したpage（この場合、タスク一覧画面）に"書類作成"という文字列が、have_content（含まれていること）をexpect（確認・期待）する
                expect(task.errors.messages).to eq ({})                # expectの結果が「真」であれば成功、「偽」であれば失敗としてテスト結果が出力される
            end
        end
    end

    describe 'list display' do
        context 'fonction when transitioning to' do
            it 'the list screen a list of registered tasks is displayed' do
                task = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.new, priority: 2, status: 1, user_id: 1)

                visit new_task_path
                #expect(page).not_to have_content 'New Task Page'
                expect(task.errors.messages).to eq ({})  
            end
        end
    end

    describe 'registration function' do
        context 'when you register a task' do
            it 'the registered tasks is displayed' do
                task = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.new, priority: 2, status: 1, user_id: 1)

                visit tasks_path
                expect(task.errors.messages).to eq ({}) 
            end
        end
    end

    describe 'detailed display' do
        context 'fonction when transitioning to any task details screen' do
            it 'the contents of the task are displayed' do        
                task = Task.create(id: 1, title: "task#{1}", content:"content#{1}", deadline_on: Date.new, priority: 2, status: 1, user_id: 1)
                visit task_path(task.id)
                expect(task.errors.messages).to eq ({})             end
        end
    end

    describe 'list display function' do
        context 'when transitioning to the context list screen' do
            it 'created task is displayed in descending order of creation date' do
                task = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.current, priority: 2, status: 1, user_id: 1)

                sleep 1
                task1 = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.current, priority: 2, status: 1, user_id: 1)
                sleep 1
                task2 = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.current, priority: 2, status: 1, user_id: 1)
                sleep 1
                task3 = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.current, priority: 2, status: 1, user_id: 1)
                
                visit tasks_path
                #task_list = all('body tr')
                len = page.all('.XPath').length
                tab = []
                task_list = page.all('.XPath')
                len.times do |n|
                    tab << task_list[n].text
                end
                tab1 = tab.sort {|a, b| b <=> a}
                expect(tab).to eq(tab1)
            end
        end

        context 'if you create a new task do' do
            it 'new tasks appear on  top' do
                task = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.current, priority: 2, status: 1, user_id: 1)

                sleep 1
                task1 = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.current, priority: 2, status: 1, user_id: 1)
                sleep 1
                task2 = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.current, priority: 2, status: 1, user_id: 1)
                sleep 1
                task3 = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.current, priority: 2, status: 1, user_id: 1)
                
                visit tasks_path
                #task_list = all('body tr')
                len = page.all('.XPath').length
                tab = []
                task_list = page.all('.XPath')
                len.times do |n|
                    tab << task_list[n].text
                end
                tab1 = tab.sort {|a, b| b <=> a}
                expect(task3.created_at).to be > (task2.created_at)
                expect(task.errors.messages).to eq ({})
            end
        end
    end

    describe 'List display function' do
        # let!を使ってテストデータを変数として定義することで、複数のテストでテストデータを共有できる
        task = Task.create(title: "task#{1}", content:"content#{1}", deadline_on: Date.current, priority: 2, status: 1, user_id: 1)
        # 「When transitioning to the list screen」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
        before do
          visit tasks_path
        end
   
       context 'When transitioning to the list screen' do
         it 'The created task list is displayed' do
           # task = FactoryBot.create(:task, title: 'task')
           visit tasks_path(task.id)
           # omit
           expect(task.errors.messages[:user]).to eq (["を入力してください"]) 
         end
       end
   
       context '新たにタスクを作成した場合' do
         it '新しいタスクが一番上に表示される' do
           # task = FactoryBot.create(:task, title: 'task')
           visit tasks_path
           # omit
           expect(task.errors.messages[:user]).to eq (["を入力してください"])  
         end
       end
     end

end
