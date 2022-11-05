class Public::ThemesController < ApplicationController

  def index
    @themes = Theme.all
    #@job = Job.find(params[:id])
  end

  def show
    @thema = Thema.find(params[:id])
    thema.update(interest: @thema.interest + 1)
  end

  def new
  end
end
