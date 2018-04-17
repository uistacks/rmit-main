class Admin::BlogController < Admin::BaseController
  def list
  	ifAdminLoggedIn
  	@list_blog_post = TransBlogPost.group(:id).order(id: 'desc')
  end

  def add
  	ifAdminLoggedIn
  end

  def create
  	ifAdminLoggedIn
  	  @admin = MstUser.find_by(:id => session[:user_id])
  	  # render json: params
      if params[:add_blog_post][:blog_image]
        @file_name = TransBlogPost.upload_image(params[:add_blog_post][:blog_image])
      else
        @file_name = '';
      end
      if params[:add_blog_post][:post_title] != ''
        @blog_post = TransBlogPost.create(
            :post_title => params[:add_blog_post][:post_title],
            :seo_url => seoUrls(params[:add_blog_post][:post_title]),
            :post_short_description => params[:add_blog_post][:post_short_description],
            :post_content => params[:add_blog_post][:post_content],
            :posted_by => @admin.id,
            :blog_image => @file_name,
            :status => params[:add_blog_post][:status],
            :lang_id => params[:add_blog_post][:lang_id]
        )
        flash[:success]= "Blog post created successfully"
        redirect_to admin_blog_list_url
      else
        flash[:error]= "Please filled all information proper...!"
        redirect_to admin_blogpost_add_url
      end
  end
  def edit
  	ifAdminLoggedIn
  	@post_id = Base64.decode64(params[:post_id]) 
  	if  @post_id != ''
  		@blog_post = TransBlogPost.find_by(:id => @post_id)
  	end	
  end

  def update
  	ifAdminLoggedIn
  	@blog_post = TransBlogPost.find_by(:id => Base64.decode64(params[:post_id]))
      if @blog_post.nil?
        flash[:error]= t("record_not_found")
        redirect_to admin_blog_list_url
      else
        @blog_post.update(
            :post_title => params[:update_blog_post][:post_title],
            :seo_url => seoUrls(params[:update_blog_post][:post_title]),
            :post_short_description => params[:update_blog_post][:post_short_description],
            :post_content => params[:update_blog_post][:post_content],
            :status => params[:update_blog_post][:status],
            :lang_id => params[:update_blog_post][:lang_id]
        )
        if params[:update_blog_post][:blog_image]
          # @image_to_delete = "public/blog_images/"+(@blog_post.blog_image)
          # if File.exist?(@image_to_delete)
          #   File.delete(@image_to_delete)
          # end
          @file_name = TransBlogPost.upload_image(params[:update_blog_post][:blog_image])
          @blog_post.update(:blog_image => @file_name)
        end
        flash[:success]= "Record updated successfully"
        redirect_to admin_blog_list_url
      end
  end

  def destroy
  	ifAdminLoggedIn
  	@post_id = params[:post_id]
  	if @post_id.nil? == false
  		@post = TransBlogPost.find_by(:id => Base64.decode64(@post_id))
  		if @post.nil? == false
  			@post.destroy
  			flash[:success] = "Blog post deleted successfully"
  		else
  			flash[:success] = "Record not found"
  		end
  		redirect_to admin_blog_list_url
  	end	
  end	

  def list_comment
  	ifAdminLoggedIn
  	@post_id = Base64.decode64(params[:post_id])
  	@list_post_comments = TransBlogComment.where(:post_id => @post_id)
  	# render json: @list_post_comments
  	if @list_post_comments.nil?
        flash[:error]= "Record not found"
        redirect_to admin_blog_list_url
    end
  end	

  def add_comment
      ifAdminLoggedIn	
      @admin = MstUser.find_by(:id => session[:user_id])
      @post_id = params[:post_id]
      # @post_data = TransBlogComment.find_by(:id => Base64.decode64(params[:post_id]));
  end

  def create_comment
	ifAdminLoggedIn    
    @user_data = TransUserInformation.find_by(:user_id => session[:user_id]);
  	@blog_post = TransBlogComment.create(
      :post_id => Base64.decode64(params[:post_id]),
      :commented_by => @user_data.user_name,
      :commented_user_id => session[:user_id],
      :comment => params[:add_post_comment][:comment],
      :status => params[:add_post_comment][:status]
      )
    flash[:success]= "Blog comment created successfully"
    redirect_to admin_comment_list_url(:post_id => params[:post_id])
  end

  def edit_comment
	    ifAdminLoggedIn	    
        @blog_comment = TransBlogComment.find_by(:id => Base64.decode64(params[:comment_id]))
  end

  def update_comment
      @blog_comment = TransBlogComment.find_by(:id => Base64.decode64(params[:comment_id]))
      if @blog_comment.nil?
        flash[:error] = "Record not found"
        redirect_to admin_comment_list_url(:post_id => Base64.encode64(params[:update_post_comment][:post_id]))
      else
        @blog_comment.update(
            :comment => params[:update_post_comment][:comment],
            :status => params[:update_post_comment][:status]
        )
        flash[:success] = "Comment updated successfully"
        redirect_to admin_comment_list_url(:post_id => Base64.encode64(params[:update_post_comment][:post_id]))
      end
  end

  def destroy_comment
  	ifAdminLoggedIn
  	@comment_id = params[:comment_id]
  	@post_id = params[:post_id]
  	# render json: @post_id
  	if @comment_id.nil? == false
  		@comment = TransBlogComment.find_by(:id => Base64.decode64(@comment_id))
  		if @comment.nil? == false
  			@comment.destroy
  			flash[:success] = "Comment deleted successfully"
  		else
  			flash[:success] = "Record not found"
  		end
  		redirect_to admin_comment_list_url(:post_id => @post_id)
  	end	
  end	
end
