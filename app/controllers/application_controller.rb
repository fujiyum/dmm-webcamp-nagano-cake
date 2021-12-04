class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path          #注文履歴一覧画面
    when Customer
      homes_path              #トップページ
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
      homes_path
    elsif resource_or_scope == :admin
      new_admin_session_path
    else
      homes_path
    end
  end

end