class ArticlesController < ApplicationController

  before_action :set_categories
    
  def index
    @title = "Listagem de Artigos"
    @articles = Article.all
  end

  def show
    begin
      @article = Article.find(params[:id])
    rescue
      redirect_to articles_path
    end
  end

  def edit
    begin
      @article = Article.find(params[:id])
    rescue
      redirect_to articles_path
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :category_id)
    end

    def set_categories
      @categories = Category.all.order(:name)
    end
end