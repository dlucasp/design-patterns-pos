class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    respond_to do |format|
      if @article.save
        # Format HTML representa o padrão de projeto Template, que redefine partes do algoritmo
        # sem mudar a estrutura do codigo.
        format.html { redirect_to @article, notice: 'Artigo criado com sucesso.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Artigo atualizado com sucesso' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      # format.html design Template
      format.html { redirect_to articles_url, notice: 'Artigo apagado.' }
      format.json { head :no_content }
    end
  end

  # Esse trecho contém a logica para encapsular os atributos do Artigo dos quais são passados 
  # apenas ao chamar os métodos create e update (linhas 27 e 45)
  # article_params 'esconde' os atributos e define as permissões
  private
    def set_article
      @article ||= Article.find(params[:id]) #Memoization ou padrão de memorização 
      # permite executar consultas ou cálculos caros uma vez por sessão 
      # O operador ||= é a chave para a memoização. 
      # A primeira chamada para o método #set_article resultará em uma 
      # consulta ao banco de dados, mas cada chamada subseqüente usará o valor em memória.
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end
end
