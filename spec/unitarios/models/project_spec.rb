require 'rails_helper'

# DESAFIO
RSpec.describe Project, type: :model do

  describe 'associações' do
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end

  describe 'validações' do

    describe 'title' do
      it { is_expected.to validate_presence_of(:title) }
    end
  end

  describe 'percentage_format' do

    it 'Deve retornar completed_percent no formato -> "N%" ' do
      project = Project.create(title: "Test controller")
      project.stub(completed_percent: 10)

      expect(project.percentage_format).to eq('10%')
    end
  end
end