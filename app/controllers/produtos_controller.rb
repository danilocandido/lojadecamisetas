class ProdutosController < ApplicationController

	#Chamar o método set_produto APENAS ANTES dos métodos :edit, :update, :destroy
	before_action :set_produto, only: [:edit, :update, :destroy]

	def index
		@produtos_por_nome = Produto.order(:nome).limit 5
		@produtos_por_preco = Produto.order(:preco).limit 2
	end

	def new
		@produto = Produto.new
		renderiza :new
	end

	def create
		@produto = Produto.new produto_params
		if @produto.save
			flash[:notice] = "Produto Salvo com Sucesso"
			redirect_to root_url
		else
			renderiza :new
		end
	end

	def destroy
		@produto.destroy
		redirect_to root_url
	end

	def busca
		@nome_a_buscar = params[:nome]
		@produtos = Produto.where "nome like ?", "%#{@nome_a_buscar}%"
		render "busca"
	end

	def edit
		renderiza :edit
	end

	def update
		if @produto.update produto_params
			flash[:notice] = "Produto atualizado com Sucesso"
			redirect_to root_url
		else
			renderiza :edit
		end
	end

	private
	def renderiza(minha_view)
		@departamentos = Departamento.all
		render minha_view
	end

	def set_produto
		id = params[:id]
		@produto = Produto.find id
	end

	def produto_params
		params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id
	end

end
