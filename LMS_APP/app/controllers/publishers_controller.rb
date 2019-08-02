class PublishersController < ApplicationController
  def new
  	@publisher = Publisher.new
  end

  def show
  	@publisher = Publisher.find(params[:id])
  end

  def create
  	@publisher = Publisher.new(publisher_params)
  	if(@publisher.save)
  		flash[:success] = "Create publisher complete"
  		redirect_to @publisher
  	else
  		render 'new'
  	end
  end

  private

  	def publisher_params
  		params.require(:publisher).permit(:name, :address, :content)
  	end

end
