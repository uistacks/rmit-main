class BlogController < ApplicationController
  
  def index
    @page_title = "Blog"
    @arr_posts = TransBlogPost.where(:status => 'Published', :lang_id => current_lang_id)
    @recent_post = TransBlogPost.where(:status => 'Published', :lang_id => current_lang_id)
    @arr_blog_comments = TransBlogComment
    					.joins('LEFT JOIN trans_user_informations as u ON u.user_id = trans_blog_comments.commented_user_id LEFT JOIN trans_blog_posts as p ON p.id = trans_blog_comments.post_id')
    					.select('trans_blog_comments.*','u.id as user_id','u.user_name','u.profile_picture','p.post_title,p.seo_url')
    					.where(:status => 'Published').order('id desc')
  end
  
  def detail
    @page_title = "Blog"
    @seo_url = params[:seo_url]
    @postdata = TransBlogPost.find_by(:seo_url => @seo_url,:status => 'Published')
    if @postdata.blank? == true
        flash[:error] = "Post not found"
        redirect_to blog_url
    end
    @recent_post = TransBlogPost.where(:status => 'Published', :lang_id => current_lang_id)
    @arr_blog_comments = TransBlogComment
              .joins('LEFT JOIN trans_user_informations as u ON u.user_id = trans_blog_comments.commented_user_id LEFT JOIN trans_blog_posts as p ON p.id = trans_blog_comments.post_id')
              .select('trans_blog_comments.*','u.id as user_id','u.user_name,u.profile_picture','p.post_title,p.seo_url')
              .where('p.seo_url' => @seo_url, :status => 'Published').order('id desc')
  end

  def comment
      if session[:user_id].nil?
        @user_data = TransUserInformation.find_by(:user_id => session[:user_id]);
      end    
      @postdata = TransBlogPost.find_by(:post_title => params[:comment][:post_title])
      @blog_post = TransBlogComment.create(
          :post_id => @postdata.id,
          :commented_by => params[:comment][:commented_by_name],
          :commented_user_id => (session[:user_id]) ? session[:user_id] : '',
          :comment => params[:comment][:comment_desc],
          :status => 'Unpublish'
      )
      flash[:success]= t("your_comment_has_been_posted")
      redirect_to blog_details_url(:seo_url => @postdata.seo_url)
  end

  def blog_search
    @page_title = "Blog"
    @title = params[:blog_search][:title]
    @arr_posts = TransBlogPost.where("post_title LIKE ?", "%#{@title}%").where(:status => 'Published', :lang_id => current_lang_id)
    @recent_post = TransBlogPost.where(:status => 'Published', :lang_id => current_lang_id)
    @arr_blog_comments = TransBlogComment
              .joins('LEFT JOIN trans_user_informations as u ON u.user_id = trans_blog_comments.commented_user_id LEFT JOIN trans_blog_posts as p ON p.id = trans_blog_comments.post_id')
              .select('trans_blog_comments.*','u.id as user_id','u.user_name','u.profile_picture','p.post_title,p.seo_url')
              .where('p.seo_url' => @seo_url, :status => 'Published').order('id desc')
    render 'blog/index'
  end 
end
