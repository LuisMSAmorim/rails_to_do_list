require 'rails_helper'

RSpec.describe Task, type: :model do
    
    let(:task) { Task.new(title: 'Test') }

    describe 'associações' do
        it { is_expected.to belong_to(:project) }
    end

    describe 'validações' do

        describe 'title' do
            it { is_expected.to validate_presence_of(:title) }
            it { is_expected.to validate_length_of(:title).is_at_most(255) }
        end

        describe 'dates' do
            it { is_expected.to validate_presence_of(:date_start) }
            it { is_expected.to validate_presence_of(:date_end) }
    
            it 'não deve aceitar data de início maior que data de fim' do
                #setup
                task.date_start = Time.now
                task.date_end = Time.now - 1.day
    
                #execução
                task.valid?
    
                #expect
                expect(task.errors.added?(:date_start, "Can't be greater than date end")).to eq(true)
            end
        end
    end

    describe 'human state' do 
        
        it 'deve retornar "Concluído" quando o estado for true' do
            task.stub(state: true)
            expect(task.human_state).to eq('Concluído')
        end
        
        it 'deve retornar "Pending" quando o estado for false' do
            task.stub(state: false)
            expect(task.human_state).to eq('Pendente')
        end

        it 'deve retornar "Pending" quando o estado for nil' do
            task.stub(state: nil)
            expect(task.human_state).to eq('Pendente')
        end
    end

    describe 'dealine status' do 

        context "Tarefa ainda não finalizada" do

            before do
                task.stub(human_state: "Pendente")
            end
            
            it 'Deve retornar "Dentro do prazo" caso a end_date seja maior que a data atual' do
                task.date_end = Time.now + 1.day
                expect(task.deadline_status).to eq('Dentro do prazo')
            end

            it 'Deve retornar "Prazo expirado" caso a end_date seja menor que a data atual' do
                task.date_end = Time.now - 1.day
                expect(task.deadline_status).to eq('Prazo expirado')
            end
        end

        context "Tarefa já finalizada" do

            it 'Deve retornar "Finalizada"' do
                task.stub(human_state: "Concluído")
                expect(task.deadline_status).to eq('Finalizada')
            end
        end
    end
end