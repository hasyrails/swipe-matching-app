class SessionsController < Devise::SessionsController

  protected

  def after_sign_in_path_for(resource)
    users_path
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    root_path
  end
end
