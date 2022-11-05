class Public::ThemesController < ApplicationController
  def index
    @themes = Theme.all
  end

  def show
  end
end
