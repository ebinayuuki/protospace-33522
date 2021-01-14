class ApplicationController < ActionController::Base

  #devise機能のための記述
  before_action :configure_permitted_parameters, if: :devise_controller?


  private
  # devise機能へのストロングパラメータ  下記カラムの値のみ取得を許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
  end

end


