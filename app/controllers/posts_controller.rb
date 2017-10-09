  class PostsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!, except: [:new, :create]
  before_action :check_moderator!, only: [:new, :create]
  # GET /posts
  # GET /posts.json
    def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = @post.comments.build
    @last_comments = @post.comments.last(5) 
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
 

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :picture, :language, :picture_cache)
    end
    def check_moderator!
      authenticate_user!
      unless current_user.moderator?
        redirect_to root_path, alert: "No tienes acceso"
        
      end
      
    end
end