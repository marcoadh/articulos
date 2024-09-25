class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  def index
    @articles = Article.order(created_at: :desc).with_rich_text_content_and_embeds 
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend('articles', partial: 'articles/article', locals: { article: @article })
        end
      else
        format.html do
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@article, partial: 'articles/article', locals: { article: @article })
        end
      else
        format.html do
          render :edit, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy

  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
