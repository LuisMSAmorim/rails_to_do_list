require 'rails_helper'

RSpec.describe ProjectService, type: :service do

    before :all do
        @project_service = ProjectService.new
        @project_id = 1
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
    end
end