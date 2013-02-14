class HomeController < ApplicationController

  def index
    @tools = Tool
      .order("name")
      .page(params[:page])
      .per_page(15)

  end

  def search
    @tools = Tool
      .where('name LIKE ?', "%#{params[:search_field]}%")
      .order("name")
      .page(params[:page])
      .per_page(15)

    render :index
  end
end
