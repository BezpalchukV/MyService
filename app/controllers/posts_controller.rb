class PostsController < ApplicationController

  require 'open-uri'
  require 'nokogiri'

  before_action :set_post, only: [:show]

  def index

    Nokogiri::HTML(open('http://waitbutwhy.com'))
    @posts = Post.order(created_at: :desc)
    #@posts = Post.all
  end


  def show
  end

  def add_to_favorites
    current_user.posts << [@post]
  end

  def add_to_fav
    current_user.posts << Post.find(params[:post])
    current_user.save
    respond_to do |format|
      format.html { redirect_to :back}
      # format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :body)
  end

end
