class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
    devise_parameter_sanitizer.permit(:account_update, keys: [:name]) #  更新時(update時)にnameというキーのパラメーターを追加で許可する
    devise_parameter_sanitizer.permit(:account_update, keys: [:icon]) #  更新時(update時)にiconというキーのパラメーターを追加で許可する
  end
end
