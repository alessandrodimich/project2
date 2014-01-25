class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      respond_to do |format|
        format.html do
          flash[:success] = "Micropost created!"
          redirect_to root_url
        end
        format.js do
          render 'create.js.erb'
        end
      end

    else
      respond_to do |format|
        format.html do
          @feed_items = []
          render 'static_pages/home'
        end
        format.js { render 'fail_create.js.erb' }
      end
    end
  end

  def destroy
    @micropost.destroy
    respond_to do |format|
      format.html do
        flash[:info] = "Micropost has been deleted"
        redirect_to root_url
      end
      format.js do
      end
    end

  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
