class HomeController < ApplicationController
  include RateProgrammerTools

  def search
    @result_model = ResultModel.new
    tools = Tool.where('name LIKE ?', "%#{params[:search_field]}%").all
    if tools.count > 0
      @result_model.model = tools
    else
      @result_model.add_error "No tool was found matching that name"
    end
    render :index
  end
end
