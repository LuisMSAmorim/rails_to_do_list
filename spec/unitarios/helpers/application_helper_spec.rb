require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

    describe 'class_name' do

        it 'deve retornar alert alert-success quando type for notice' do
            type = 'notice'

            expect(class_name(type)).to eq('alert alert-success')
        end

        it 'deve retornar alert alert-danger quando type for error' do
            type = 'error'

            expect(class_name(type)).to eq('alert alert-danger')
        end

        it 'deve retornar alert alert-warning quando type for diferente de notice ou error' do
            type = 'diferente'

            expect(class_name(type)).to eq('alert alert-warning')
        end
    end
end