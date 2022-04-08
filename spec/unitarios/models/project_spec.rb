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
end