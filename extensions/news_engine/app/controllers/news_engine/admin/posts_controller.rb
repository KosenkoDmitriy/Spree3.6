class NewsEngine::Admin::PostsController < Spree::Admin::BaseController

  def index
    @posts ||= Post.order("posts.post_type ASC, IFNULL(published_on, created_at) DESC").
      page(params[:page]).
      per(Spree::Config[:admin_products_per_page])
  end

  def show
    @post = Post.find_by_permalink(params[:id])

    respond_to do |format|
      format.html  # show.html.erb
      #format.json  { render :json => @post }
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
        format.html  # new.html.erb
        #format.json  { render :json => @post }
    end
  end
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html  { redirect_to(admin_post_url(@post),
          :notice => 'Post was successfully created.') }
        #format.json  { render :json => @post,
        #	:status => :created, :location => @post }
      else
        format.html  { render :action => "new" }
        #format.json  { render :json => @post.errors,
        #	:status => :unprocessable_entity }
      end
      end
  end

  def edit
    @post = Post.find_by_permalink(params[:id])

    respond_to do |format|
        format.html  # new.html.erb
    end
  end

  def update
    @post = Post.find_by_permalink(params[:id])

    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html  { redirect_to(admin_post_url(@post),
          :notice => 'Post was successfully updated.') }
        #format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        #format.json  { render :json => @post.errors,
        #	:status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find_by_permalink(params[:id])

    respond_to do |format|
      if @post.destroy
        format.html { redirect_to admin_posts_url }
      else
        format.html { redirect_to admin_post_url(@post), :error => "Post was not deleted." }
      end
    end
  end

  def unpublish
    @post = Post.find_by_permalink(params[:id])
    respond_to do |format|
      @post.unpublish!
      format.html { redirect_to admin_posts_url }
    end
  end

  # def object
  # 	@object ||= Post.find_by_permalink(params[:id])
  # 	@post ||= @object
  # end

  # def collection
  # 	@collection ||= Post.order("posts.post_type ASC, IFNULL(published_on, created_at) DESC").paginate(
  # 		:per_page => Spree::Config[:admin_products_per_page],
  # 		:page => params[:page]
  # 		)
  # end

  def picker_index
  end

  def picker_gallery
    @gallery = Gallery.find params[:gallery_id]
    render :partial => "picker_gallery", :locals => {:gallery => @gallery}
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :post_type, :published_on, :body_extended, :permalink)
  end
end
