class Admin::GenresController < Admin::AdminController

  def index
    @genres = Genre.all.page(params[:page]).per(14)
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
      if @genre.save
        redirect_to admin_genres_path, notice: "ジャンルを追加しました。"
      else
        flash[:notice] = "ジャンルを追加できませんでした。"
        @genres = Genre.all.page(params[:page]).per(14)
        render :index
      end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
      if @genre.update(genre_params)
        redirect_to admin_genres_path, notice: "編集が完了しました。"
      else
        flash[:notice] = "更新できませんでした。入力内容をご確認ください。"
        @genre = Genre.find(params[:id])
        render :edit
      end
  end

  #ジャンル名編集画面で、エラーメッセージが表示されている時にリロードをするとRouting Errorが出てしまう事への対処
  def dummy
    redirect_to edit_admin_genre_path(params[:id])
  end


  private
    def genre_params
      params.require(:genre).permit(:name)
    end
end
