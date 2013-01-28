class HomeController < ApplicationController

  def search
    @tools = Tool.where('name LIKE ?', "%#{params[:search_field]}%").all
    respond_to  do |format|
      format.js { render :tool_result_set }
    end
  end
end
