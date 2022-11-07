class Admin::JobsController < ApplicationController

  def index
    @jobs = Job.all.order(created_at: :desc)
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
  end

end
