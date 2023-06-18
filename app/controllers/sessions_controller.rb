class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # セッション固定対応、ログイン前にセッションIDをリセットして対処
      reset_session
      # ユーザログイン後にユーザ情報ページにリダイレクトする
      log_in user
      redirect_to user
    else
      # エラーメッセ維持を作成して、newアクションへ
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

end