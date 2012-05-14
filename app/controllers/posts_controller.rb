class PostsController < ApplicationController
  
  def index
    @posts = Post.threads

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end
=begin  
  def edit
    @post = Post.find(params[:id])
  end
=end
  def create
    attach = params[:attach].nil? || params[:post][:post_id].blank?
    if attach
      params[:post][:post_id] = nil 
      @post = Post.create(params[:post])
    else
      parent = Post.find(params[:post][:post_id])
      @post = Post.create(params[:post])
    end  
    
    
    respond_to do |format|
      if @post.save 
        format.html { redirect_to parent || @post, notice: 'Post was successfully created.' }
        format.json { render json: parent || @post, status: :created, location: parent || @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

=begin  
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
=end 
 
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
