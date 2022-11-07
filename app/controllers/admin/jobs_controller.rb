class Admin::JobsController < ApplicationController

  def index
    @jobs = Job.all.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

end
