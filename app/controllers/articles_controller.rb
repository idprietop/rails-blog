class ArticlesController < ApplicationController
  before_action :validate_session
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.user_id == current_user.id
      if @article.update(article_params)
        redirect_to @article
      else
        render :edit
      end
    else
      redirect_to @article
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.user_id == current_user.id
      @article.destroy
      redirect_to articles_path
    else
      redirect_to @article
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

  def validate_session
    redirect_to login_path unless logged_in?
  end
end
