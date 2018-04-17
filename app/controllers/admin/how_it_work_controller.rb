class Admin::HowItWorkController < Admin::BaseController

  def list
  	ifAdminLoggedIn
  	@how_it_works = MstHowItWork.where(:lang_id => 17).order(id: 'desc')
  end

  def add 
  	ifAdminLoggedIn
  end	

  def create 
  	ifAdminLoggedIn
  	if params[:add_howitwork][:icon]
        @file_name = MstHowItWork.upload_image(params[:add_howitwork][:icon])
    else
    	@file_name = '';
    end
  	@how_it_works = MstHowItWork.create(
  		:description => params[:add_howitwork][:description],
  		:slug => seoUrls(params[:add_howitwork][:description]),
  		:icon => @file_name,
  		:lang_id => 17,
  		:status => "1",
  		)
  	flash[:success] = "How it works added successfully"
  	redirect_to admin_how_it_work_list_url
  end

  def edit
  	ifAdminLoggedIn
  	@how_it_works = MstHowItWork.find_by(:id => Base64.decode64(params[:how_id]))
  end	

  def update
  	ifAdminLoggedIn
  	@how_it_works = MstHowItWork.find_by(:id => Base64.decode64(params[:how_id]))
  	if params[:update_howitwork][:icon]
        @file_name = MstHowItWork.upload_image(params[:update_howitwork][:icon])
        @image_to_delete = "public/how_it_work_icon/"+(@how_it_works.icon)
            if File.exist?(@image_to_delete)
              File.delete(@image_to_delete)
            end
        @how_it_works.update(
  		:icon => @file_name,
  		)
    end
  	@how_it_works.update(
  		:description => params[:update_howitwork][:description],
  		:slug => seoUrls(params[:update_howitwork][:description]),
  		:status => params[:update_howitwork][:status]
  		)
  	flash[:success] = "Record updated successfully"
  	redirect_to admin_how_it_work_list_url
  end

  def edit_multi
  	ifAdminLoggedIn
  	@how_it_works = MstHowItWork.find_by(:slug => Base64.decode64(params[:slug]),:lang_id => 12)
    if @how_it_works.blank? == true
      @how_it_works = MstHowItWork.find_by(:slug => Base64.decode64(params[:slug]))
    end 
    # render json: @how_it_works
  end	

  def update_multi
  	ifAdminLoggedIn
    # render json: params
  	@how_it_works = MstHowItWork.find_by(:slug => Base64.decode64(params[:slug]),:lang_id => 12)
  	if params[:update_howitwork][:icon] 
        @file_name = MstHowItWork.upload_image(params[:update_howitwork][:icon])
        if @how_it_works.blank? == false
        	# @image_to_delete = "public/how_it_work_icon/"+(@how_it_works.icon)
         #    if File.exist?(@image_to_delete)
         #      File.delete(@image_to_delete)
         #    end
        	@how_it_works.update(
  		    :icon => @file_name
			)
        end	
    else
    	@file_name = '';
    end
	if @how_it_works.blank? == true
		@how_it_works = MstHowItWork.create(
  		:description => params[:update_howitwork][:description],
  		:slug => Base64.decode64(params[:slug]),
  		:icon => @file_name,
  		:lang_id => 12,
  		:status => "1",
		)
		flash[:success] = "How it work added successfully"
	else
		@how_it_works.update(
  		  :description => params[:update_howitwork][:description],
			# :slug => seoUrls(params[:update_howitwork][:description]),
  		  :status =>  params[:update_howitwork][:status],
			  :lang_id => "12"
			)
		flash[:success] = "Record updated successfully"
	end	
  redirect_to admin_how_it_work_list_url
  end	

  def change_status
  	ifAdminLoggedIn
  	if params[:how_id] != ""
  		@how = MstHowItWork.find_by(:id => params[:how_id])
  		if @how.nil? == false   
       @how.update(:status => params[:status].to_s)
       flash[:success]="Status Changed successfully"
         respond_to do |format|
          format.json { render :json => {"error" => "0", "error_message" => "Status Changed successfully"} }
        end
      else
        respond_to do |format|
          format.json { render :json => {"error" => "1", "error_message" => "Sorry, your request can not be fulfilled this time. Please try again later"}}
        end
      end
    else 
      respond_to do |format|
       format.json { render :json => {"error" => "1", "error_message" => "Sorry, your request can not be fulfilled this time. Please try again later"}}
     end
    end
  end  

  def delete
    ifAdminLoggedIn
    @how = MstHowItWork.find_by(:id => Base64.decode64(params[:how_id]))
    if @how.blank? == false
      @how.destroy
    end 
    flash[:success] = "How it works deleted successfully"
    redirect_to admin_how_it_work_list_url
  end 
end
