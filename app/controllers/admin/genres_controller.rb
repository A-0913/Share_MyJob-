class Admin::GenresController < ApplicationController
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
         @genre = Genre.find(params[:id])
         render :edit
      end
  end

  private
   def genre_params
     params.require(:genre).permit(:name)
   end
end
