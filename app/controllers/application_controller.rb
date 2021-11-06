class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_admin_path          #注文履歴一覧画面
    when Customer
      root_path              #トップページ
    end
  end

end
