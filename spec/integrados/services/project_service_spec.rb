require 'rails_helper'

RSpec.describe ProjectService, type: :service do

    before do
        @project_service = ProjectService.new
        
        @project = Project.new(title: "Test")
        @project.save
    end

    describe "#create" do 

        it "Deve criar um novo projeto" do
            params = { title: "Test1" }
            project = @project_service.create(params: params)

            expect(project.title).to eq("Test1")
        end
    end

    describe "#destroy" do
            
            it "Deve deletar um projeto" do
                @project_service.destroy(project_id: @project.id)
    
                expect(Project.all.count).to eq(0)
            end
    end

    describe "#update" do

        it "Deve atualizar um projeto" do
            params = { title: "Test2" }
            project = @project_service.update(project_id: @project.id, params: params)
            
            expect(project.title).to eq("Test2")
        end
    end

    describe 'complete_percentage' do

        def set_total_and_concluded_tasks_relation(total_tasks:, task_concluded:)
            allow(Task).to receive_message_chain(:select, :where, :first) { double('Task', total_tasks: total_tasks, task_concluded: task_concluded) }
        end

        it 'Deve ser 0 caso não haja nenhuma tarefa' do
            set_total_and_concluded_tasks_relation(total_tasks: 0, task_concluded: 0)
            expect(@project_service.complete_percentage(project_id: @project_id)).to eq(0)
        end

        it 'Deve ser 0 caso só haja uma tarefa pendente' do
            set_total_and_concluded_tasks_relation(total_tasks: 1, task_concluded: 0)
            expect(@project_service.complete_percentage(project_id: @project_id)).to eq(0)
        end

        it 'Deve ser 100 caso só haja uma tarefa concluída' do
            set_total_and_concluded_tasks_relation(total_tasks: 1, task_concluded: 1)
            expect(@project_service.complete_percentage(project_id: @project_id)).to eq(100)
        end

        it 'Deve ser zero caso não haja nenhuma tarefa' do
            set_total_and_concluded_tasks_relation(total_tasks: 0, task_concluded: 0)
            expect(@project_service.complete_percentage(project_id: @project_id)).to eq(0)
        end
    end
end