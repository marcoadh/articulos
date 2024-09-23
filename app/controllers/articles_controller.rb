class ArticlesController < ApplicationController
  def index
    @articles = Article.order(created_at: :desc)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend('articles', partial: 'articles/article', locals: { article: @article })
        end
        format.html { redirect_to articles_path, notice: 'Artículo fue creado exitosamente.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
