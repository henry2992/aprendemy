class SubcategoryController < ApplicationController

  before_action :set_subcategory, only: [:show]
  
  def show
  	@exercises =  @subcategory.exercises
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subcategory
      @subcategory = Subcategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subcategory_params
      params.require(:subcategory).permit(:title)
    end

end
