class Public::ThemesController < ApplicationController

  def index
    @themes = Theme.all
    #@job = Job.find(params[:id])
  end

  def show
    @theme = Theme.find(params[:id])
    @theme.update(interest: @theme.interest + 1)
    #@job = Job.find(params[:id])
    #@comment = Comment.new

  end

  def new
  end

  def create
    @theme = Theme.new(theme_params)
    if @theme.save
      flash[:notice] = "テーマが申請されました。承認がおりると、テーマ一覧に表示されます。しばらくお待ちください。"
      redirect_to themes_path
    else
      flash[:notice] = "テーマの申請ができませんでした。申請内容をご確認ください。"
      render 'new'
    end
  end

  private
    def theme_params
      params.permit(:name, :reason )
    end

end
