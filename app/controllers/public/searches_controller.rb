class Public::SearchesController < ApplicationController

  def search
    @model = params[:model]
    @word = params[:word]
    @jobs = Job.search_for(params[:method], params[:word])
  end
end
