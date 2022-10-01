class CategoriesController < ApplicationController
    def index
      @title = "Listagem de Categorias"
      @categories = Category.all
    end  

    def show
    begin
        @category = Category.find(params[:id])
    rescue
        redirect_to categories_path
    end
    end
    
    def edit
    begin
        @category = Category.find(params[:id])
    rescue
        redirect_to categories_path
    end
    end

    def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
        redirect_to @category
    else
        render :edit, status: :unprocessable_entity
    end
    end

    def new
        @category = Category.new
    end 

    def create
    @category = Category.new(category_params)

    if @category.save
        redirect_to @category
    else
        render :new, status: :unprocessable_entity
    end
    end  
    
    def destroy
        @category = Category.find(params[:id])
        @category.destroy
    
        redirect_to categories_path, status: :see_other
    end    
    
    private
    def category_params
      params.require(:category).permit(:name)
    end    
end
