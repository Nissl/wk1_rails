class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  before_action :require_admin, only: [:new, :create]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category[:name].capitalize!

    if @category.save
      flash[:notice] = 'You added a new category: "' + @category[:name] + '"'
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @category = Category.find_by(slug: params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end