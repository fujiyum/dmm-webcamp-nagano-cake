# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

    def reject_customer #退会後の同じ登録を阻止
      @customer = Customer.find_by(email: params[:customer][:email])
       if @customer
        if @customer.vaild_password?(params[:customer][:password]) && (@customer.is_active == "有効")
         flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
         redirect_to new_customer_registration_path
        else
         flash[:notice] = "項目を入力してください"
        end
       end
    end

end
