class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path          #注文履歴一覧画面
    when Customer
      homes_path              #トップページ
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when Admin
      new_admin_session_path #管理者ログイン画面
    when Customer
      new_customer_sesion_path    #トップページ
    end
  end


end
