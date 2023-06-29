class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  # GET /users
  def index
    @users = User.paginate(page: params[:page])
    # => GET app/views/users/index.html.erb
  end

  # GET /users/:id
  def show
    # @user = User.first
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    # foo = "foobar"
    # hoge = "hogehoge"
    # debugger
    # => GET app/views/users/show.html.erb
  end

  # GET /users/new
  def new
    @user = User.new
    # => GET app/views/users/new.html.erb
  end

  # => POST /users
  def create
    # Sign-up Param => params => user => user.save
    @user = User.new(user_params)
    if @user.save
      # ユーザに登録メールを送る、トークンはmodelでDBに新規追加される際に
      # create_activation_digest内で取得済みなのでメール送信が可能
      # UserMailer.account_activation(@user).deliver_now
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      # => Failure
      render 'new', status: :unprocessable_entity
    end

  end

  # GET /users/:id/edit
  def edit
    @user = User.find(params[:id])
    # => app/views/users/edit.html.erb
  end

  # PATCH /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      # @users.errors <== User及びエラー情報等も入っている
      render 'edit', status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url, status: :see_other
  end

  private

  # Strong Parameters
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation)
  end

  # beforeフィルタ

  # 正しいユーザーかどうか確認(ログイン済み（current_user != nil）であることが前提)
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, status: :see_other) unless current_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url, status: :see_other) unless current_user.admin?
  end
end
