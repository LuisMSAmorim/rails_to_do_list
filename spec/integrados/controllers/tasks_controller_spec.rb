require 'rails_helper'

RSpec.describe TasksController, type: :controller do
    let(:project) { Project.create(title: "Test controller") }
    let(:task) { Task.create(title: "Test task", date_start: Time.now, date_end: Time.now + 2, project_id: project.id) }
    
    describe 'GET#index' do
        before do
            get :index, params: { project_id: project.id }
        end

        it 'Deve retornar status code 200' do
            expect(response.status).to eq(200)
        end

        it 'Deve renderizar o template index' do
            expect(response).to render_template(:index)
        end
    end
    
    describe 'GET#show' do
        before do
            get :show, params: { id: task.id, project_id: project.id }
        end

        it 'Deve retornar status code 200' do
            expect(response.status).to eq(200)
        end

        it 'Deve renderizar o template show' do
            expect(response).to render_template(:show)
        end
    end

    describe 'GET#new' do
        before do
            get :new, params: { project_id: project.id }
        end

        it 'Deve retornar status code 200' do
            expect(response.status).to eq(200)
        end

        it 'Deve renderizar o template new' do
            expect(response).to render_template(:new)
        end
    end

    describe 'GET#edit' do
        before do
            get :edit, params: { id: task.id, project_id: project.id }
        end

        it 'Deve retornar status code 200' do
            expect(response.status).to eq(200)
        end

        it 'Deve renderizar o template edit' do
            expect(response).to render_template(:edit)
        end
    end

    describe 'POST#create' do

        context "Se a tarefa for criada com sucesso" do

            before do
                @params = {"task"=>{"title"=>"criação", "date_start"=>"2022-04-08T09:00", "date_end"=>"2022-04-08T16:00", "state"=>"0"}, "commit"=>"Save", "project_id"=> project.id}
            end
    
            it "Deve criar um registro na tabela de tarefas" do
                expect {
                    post :create, params: @params
                }.to change(Task, :count).by(1)
            end
    
            it "Deve retornar mensagem de sucesso" do
                post :create, params: @params
                expect(response.request.flash[:notice]).to eq("Task was successfully created.")
            end
        end

        context "Se a tarefa não for criada com sucesso" do

            before do
                @params = {"task"=>{"title"=>"", "date_start"=>"2022-04-08T09:00", "date_end"=>"2022-04-08T16:00", "state"=>"0"}, "commit"=>"Save", "project_id"=> project.id}
            end
            
            it "Não deve criar um registro na tabela de tarefas" do
                expect {
                    post :create, params: @params
                }.to change(Task, :count).by(0)
            end

            it "Deve retornar status 422" do
                post :create, params: @params
                expect(response.status).to eq(422)
            end

            it "Deve renderizar o template new" do
                post :create, params: @params
                expect(response).to render_template(:new)
            end
        end
    end

    describe 'DELETE#destroy' do
        before do
            @params = { id: task.id, project_id: project.id }
        end

        it 'Deve apagar um registro da tabela de tarefas' do
            expect {
                delete :destroy, params: @params
            }.to change(Task, :count).by(-1)
        end

        it 'Deve retornar mensagem de sucesso' do
            expect {
                delete :destroy, params: @params
                expect(response.request.flash[:notice]).to eq("Task was successfully destroyed.")
            }
        end
    end

    describe 'PATCH#update' do

        context 'sucesso' do
            before do
                @params = {"task"=>{"title"=>"test"}, "commit"=>"Update", "project_id"=>project.id, "id"=>task.id}
    
                patch :update, params: @params
            end 
      
            it 'deve atualizar o título do projeto' do
                expect(task.reload.title).to eq('test')
            end
      
            it 'retorna mensagem de sucesso' do
                expect(response.request.flash[:notice]).to eq("Task was successfully updated.")
            end
          end
      
          context 'erro' do
            before do
                @params = {"task"=>{"title"=>""}, "commit"=>"Update", "project_id"=>project.id, "id"=>task.id}
                patch :update, params: @params
            end
      
            it 'não deve atualizar o título do projeto' do
                expect(task.reload.title).to eq("Test task")
            end
      
            it 'retorna status 422' do
                expect(response.status).to eq(422)
            end
      
            it 'renderiza o template edit' do
                expect(response).to render_template(:edit)
            end
          end
    end
end