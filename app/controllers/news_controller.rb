class NewsController < ApplicationController
  def index
  end

  def new
  end

  def create
    if session[:user_id].nil? != false
      flash[:error] = "Please login to procced further."
      redirect_to signin_url
    else
      user_id = session[:user_id];
      if params[:news][:question] != ""
        @news = MstNews.create(
          :user_id => user_id,
          :title => params[:news][:title],
          :slug => seoUrls(params[:news][:title]),
          :slug => params[:news][:description],
          :active => "1"
          )
        flash[:success] = "News submitted successfully."
        redirect_to root_path
      end
  	end
  end

  def edit
  end
end
