	class HomeController < ApplicationController

  def search
    @tools = Tool.where('name LIKE ?', "%#{params[:search_field]}%").all
    respond_to  do |format|
    	format.html {render :index }  #need it for redirecting users to search page.
      format.js { render :tool_result_set }
    end
  end
end
