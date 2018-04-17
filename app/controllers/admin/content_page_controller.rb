class Admin::ContentPageController < Admin::BaseController
  require 'base64'
  require 'uri'
  layout 'admin'
  def list
    ifAdminLoggedIn
    @content_pages = MstContentPage.where(:lang_id => "17").order(id: 'asc')
    # render json: @content_pages
  end

  def edit
    ifAdminLoggedIn
    @cms = MstContentPage.find_by(:id => Base64.decode64(params[:cms_id]))     
    if @cms.nil?
      flash[:error] = "CMS not found...!"
      redirect_to admin_content_page_list_url
    end
  end

  def update
    ifAdminLoggedIn       
    @cms = MstContentPage.find_by(:id => Base64.decode64(params[:cms_id]))
    if @cms.nil?
      flash[:error] = "CMS not found...!"
      redirect_to admin_content_page_list_url
    else
      @cms.update(
        :title => params[:cms_page][:title],
        :slug => seoUrls(params[:cms_page][:page_alias]),
        :content => params[:cms_page][:content],
        :meta_keyword =>params[:cms_page][:meta_keyword],
        :meta_description =>params[:cms_page][:meta_description],
        :active => "1",
        :lang_id => "17"
        )
      flash[:success] = "CMS updated Successfully...!"
      redirect_to admin_content_page_list_url
    end   
  end

  def edit_multilang
    ifAdminLoggedIn
    @cms = MstContentPage.find_by(:slug => Base64.decode64(params[:slug]), :lang_id => "12")     
    if @cms.nil?
      flash[:error] = "CMS not found...!"
      redirect_to admin_content_page_list_url
    end
    # render json: @cms
  end

  def update_multilang
    ifAdminLoggedIn       
    @cms = MstContentPage.find_by(:id => Base64.decode64(params[:cms_id]), :lang_id => "12")
    if @cms.nil?
      flash[:error] = "CMS not found...!"
      redirect_to admin_content_page_list_url
    else
      @cms.update(
        :title => params[:cms_page][:title],
        # :slug => seoUrls(params[:cms_page][:page_alias]),
        :content => params[:cms_page][:content],
        :meta_keyword =>params[:cms_page][:meta_keyword],
        :meta_description =>params[:cms_page][:meta_description],
        :active => "1",
        :lang_id => "12"
        )
      flash[:success] = "CMS updated Successfully...!"
      redirect_to admin_content_page_list_url
    end   
  end

  def check_title
    if params[:cms_page][:title] == params[:cms_page][:old_title]
      respond_to do |format|
        format.json { render :json => 'true' }
      end
    else
      @cms = MstContentPage.find_by(:title => params[:cms_page][:title])
      respond_to do |format|
        format.json { render :json => !@cms }
      end
    end
  end  
end
