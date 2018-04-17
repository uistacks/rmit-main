class Admin::CategoryController < Admin::BaseController
  require 'base64'
  require 'uri'
  layout 'admin'

  def list
    ifAdminLoggedIn
    @categories = MstCategory.where(:parent_id => "0")
    # render json: @categories.trans_categories
  end

  def add
    ifAdminLoggedIn
    @categories = TransCategory
            .joins('INNER JOIN mst_categories as c on c.id = trans_categories.category_id_fk')
            .select('c.id',:category_name,'c.parent_id')
            .where(:lang_id => "17",'c.parent_id' => 0)
    # render json: @categories
  end

  def create
    ifAdminLoggedIn
    # render json: params
    if params[:category][:cat_icon]
      @file_name = TransCategory.upload_image(params[:category][:cat_icon])
    end
    @category = MstCategory.create(
      :parent_id => (params[:category][:parent_id].blank? == false) ? params[:category][:parent_id] : "0",
      :slug => seoUrls(params[:category][:category_name])
    );
    @category_info = TransCategory.create(
    :category_name => params[:category][:category_name],
    :category_name_ch => params[:category][:category_name_ch],
    :lang_id => "17",
    :category_icon => @file_name,
    :category_id_fk => @category.id
    );
    flash[:success] = "Category added Sucessfully..!"
    redirect_to admin_category_list_url
  end

  def edit
    ifAdminLoggedIn
    @cat_id = Base64.decode64(params[:cat_id])
    @categories = TransCategory
          .joins('INNER JOIN mst_categories as c on c.id = trans_categories.category_id_fk')
          .select(:id,:category_name,:category_name_ch,:category_icon,:created_at,'c.id as cat_id, c.parent_id')
          .where('c.id' => @cat_id,:lang_id => 17)
    if @categories.nil?
      flash[:error] = "Category not found...!"
      redirect_to admin_category_list_url
    end
  end

  def update
    ifAdminLoggedIn
    @category_details = MstCategory.find_by(:id => Base64.decode64(params[:cat_id]))
    @category_details.update(
        :slug => seoUrls(params[:category][:category_name])
    );
    @category_details.trans_categories[0].update(
      :category_name => params[:category][:category_name],
      :category_name_ch => params[:category][:category_name_ch]
      )
    if params[:category][:cat_icon]
      @image_to_delete = "public/category_icon/"+(@category_details.trans_categories[0].category_icon)
      if File.exist?(@image_to_delete)
        File.delete(@image_to_delete)
      end
      @file_name = TransCategory.upload_image(params[:category][:cat_icon])
      @category_details.trans_categories[0].update(
          :category_icon => @file_name,
      )
    end
      flash[:success] = "Category updated Successfully...!"
      redirect_to admin_category_list_url
  end

  def edit_multilang
    ifAdminLoggedIn
    @cat_id = Base64.decode64(params[:cat_id])
    @categories = TransCategory
            .joins('INNER JOIN mst_categories as c on c.id = trans_categories.category_id_fk')
            .select('c.id',:category_name,:category_icon,'c.parent_id')
            .where('c.id' => @cat_id,:lang_id => 12)
    # if @categories.nil?
    #   flash[:error] = "Category not found...!"
    #   redirect_to admin_category_list_url
    # end
  end

  def update_multilang
    ifAdminLoggedIn       
    @category_details = TransCategory.find_by(:category_id_fk => Base64.decode64(params[:cat_id]),:lang_id => 12)
    # render json: @category_details
    if @category_details.nil? == true
      @encategoryinfo = TransCategory.find_by(:category_id_fk => Base64.decode64(params[:cat_id]),:lang_id => 17)
        @category = TransCategory.create(
        :category_name => params[:category][:category_name],
        :category_icon => @encategoryinfo.category_icon,
        :lang_id => 12,
        :category_id_fk => Base64.decode64(params[:cat_id])
        )
        if params[:category][:cat_icon]
          @category_img = TransCategory.find_by(:id => @category.id)
          @file_name = TransCategory.upload_image(params[:category][:cat_icon])
          @category_img.update(
              :category_icon => @file_name
          )
        end
        flash[:success] = "Category added Sucessfully..!"
        redirect_to admin_category_list_url
    else
      @category_details.update(
          :category_name => params[:category][:category_name]
      )
      if params[:category][:cat_icon]
          @image_to_delete = "public/category_icon/"+(@category_details.category_icon)
          if File.exist?(@image_to_delete)
            File.delete(@image_to_delete)
          end
            @file_name = TransCategory.upload_image(params[:category][:cat_icon])
          @category_details.update(
                :category_icon => @file_name
            )
      end
      flash[:success] = "Category updated Successfully...!"
      redirect_to admin_category_list_url
    end
  end  

  def check_category_name
    if params[:category][:type] == "edit"
      if params[:category][:category_name].downcase == params[:category][:old_category_name].downcase
        respond_to do |format|
          format.json { render :json => 'true' }
        end
      else
        @category  = TransCategory.find_by(:category_name => params[:category][:category_name]);
        respond_to do |format|
          format.json { render :json => !@category }
        end
      end
    else
      if params[:category][:category_name]
         @category = TransCategory.find_by(:category_name => params[:category][:category_name])
         respond_to do |format|
         format.json { render :json => !@category }
        end
      end
    end
  end

  def destroy
    ifAdminLoggedIn
    
    @category = MstCategory.find_by(:id => Base64.decode64(params[:cat_id]))
    # render json: @category
    if @category.blank? == false
      @category.destroy
    end 
    flash[:success] = "Category deleted successfully"
    redirect_to admin_category_list_url
  end 

  def list_subcategory
    ifAdminLoggedIn
    @cat_id = Base64.decode64(params[:cat_id])
    @subcategories = TransCategory
            .joins('INNER JOIN mst_categories as c on c.id = trans_categories.category_id_fk')
            .select('trans_categories.*' ,'c.parent_id')
            .where('c.parent_id' => @cat_id,:lang_id => 17)
    # render json: @subcategories
  end  

  def add_subcategory
    ifAdminLoggedIn
    @cat_id = params[:cat_id]
  end  

  def create_subcategory
    ifAdminLoggedIn
    @cat_id = Base64.decode64(params[:cat_id])
    @category = MstCategory.create(
      :parent_id => @cat_id,
      :slug => seoUrls(params[:subcategory][:category_name])
    );
    @category_info = TransCategory.create(
    :category_name => params[:subcategory][:category_name],
    :category_name_ch => params[:subcategory][:category_name_ch],
    :lang_id => "17",
    :category_id_fk => @category.id
    );
    flash[:success] = "Subcategory added Sucessfully..!"
    redirect_to admin_subcategory_list_url(:cat_id => Base64.encode64(@cat_id))
  end  


  def check_subcategory_name
    if params[:subcategory][:type] == "edit"
      if params[:subcategory][:category_name].downcase == params[:subcategory][:old_category_name].downcase
        respond_to do |format|
          format.json { render :json => 'true' }
        end
      else
        @category  = TransCategory.find_by(:category_name => params[:subcategory][:category_name]);
        respond_to do |format|
          format.json { render :json => !@category }
        end
      end
    else
      if params[:subcategory][:category_name]
         @category = TransCategory.find_by(:category_name => params[:subcategory][:category_name])
         respond_to do |format|
         format.json { render :json => !@category }
        end
      end
    end
  end

  def edit_subcategory
    ifAdminLoggedIn
    @cat_id = params[:cat_id]
    @subcat_id = Base64.decode64(params[:subcat_id])
    @subcategory = TransCategory.find_by(:id => @subcat_id,:lang_id => 17)
  end

  def update_subcategory
    ifAdminLoggedIn
    @cat_id = params[:cat_id]
    @subcat_id = Base64.decode64(params[:subcat_id])
    @subcategory = TransCategory.find_by(:id => @subcat_id)
    @subcategory.update(
      :category_name => params[:subcategory][:category_name],
      :category_name_ch => params[:subcategory][:category_name_ch]
    )
    @category_details = MstCategory.find_by(:id => @subcategory.category_id_fk)
    @category_details.update(
        :slug => seoUrls(params[:subcategory][:category_name])
    );
    flash[:success] = "Category updated Successfully...!"
    redirect_to admin_subcategory_list_url(:cat_id => @cat_id)
  end

  def destroy_subcategory
    ifAdminLoggedIn
    @cat_id = params[:cat_id]
    @subcat_id = Base64.decode64(params[:subcat_id])
    @subcategory = TransCategory.find_by(:id => @subcat_id)
    @category = MstCategory.find_by(:id => @subcategory.category_id_fk)
    if @category.blank? == false
      @category.destroy
    end 
    flash[:success] = "Subcategory deleted successfully"
    redirect_to admin_subcategory_list_url(:cat_id => @cat_id)
  end
end
