
require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  # DESAFIO
  # adicionar os expects
  # substituir a constante VERBO_HTTP pelo verbo http GET, POST, DELETE, PUT....
  # substituir a constante STATUS_HTTP pelo código http 200, 201 ... (https://httpstatusdogs.com/)

  describe 'VERBO_HTTP#index' do
    before do
    end

    it 'retorna status STATUS_HTTP' do
    end

    it 'renderiza o template index' do
    end
  end

  describe 'VERBO_HTTP#new' do
    before do
    end

    it 'retorna status STATUS_HTTP' do
    end

    it 'renderiza o template new' do
    end
  end

  describe 'VERBO_HTTP#create' do
    context 'sucesso' do
      before do
      end

      it 'deve criar um registro' do
      end

      it 'retorna mensagem de sucesso' do
      end
    end

    context 'erro' do
      before do
      end

      it 'não deve criar um registro' do
      end

      it 'retorna status STATUS_HTTP' do
      end

      it 'renderiza o template new' do
      end
    end
  end

  describe 'VERBO_HTTP#show' do
    before do
    end

    it 'retorna status STATUS_HTTP' do
    end

    it 'renderiza o template show' do
    end
  end

  describe 'VERBO_HTTP#edit' do
    before do
    end

    it 'retorna status STATUS_HTTP' do
    end

    it 'renderiza o template edit' do
    end
  end

  describe 'VERBO_HTTP#update' do
    context 'sucesso' do
      before do
      end

      it 'deve atualizar o título do projeto' do
      end

      it 'retorna mensagem de sucesso' do
      end
    end

    context 'erro' do
      before do
      end

      it 'não deve atualizar o título do projeto' do
      end

      it 'retorna status STATUS_HTTP' do
      end

      it 'renderiza o template edit' do
      end
    end
  end

  describe 'VERBO_HTTP#destroy' do
    it 'deve apagar um registro' do
    end

    it 'retorna mensagem de sucesso' do
    end
  end
end 