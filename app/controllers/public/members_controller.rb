class Public::MembersController < ApplicationController
  def show
    @member = Member.find(params[:id])
  end

  def edit
  end

  def confirm
  end
end
