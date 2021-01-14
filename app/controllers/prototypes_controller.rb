class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end

  end  

  def edit

    if user_signed_in? && current_user.id == Prototype.find(params[:id]).user_id
      @prototype = Prototype.find(params[:id])
    else
      redirect_to root_path
    end  
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end

  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end
    

  

  private
  # 投稿機能のストロングパラメータ  下記カラムの値のみ取得を許可する
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
  
end
