class UsersController < ApplicationController

  # => /users
  def index
    # => GET app/views/users/index.html.erb
  end

  # => /users/:id
  def show
    # @user = User.first
    @user = User.find(params[:id])
    foo = "foobar"
    hoge = "hogehoge"
    # debugger
    # => GET app/views/users/show.html.erb
  end

  # /users/new
  def new
    @user = User.new
    # => GET app/views/users/new.html.erb
  end

  # => POST /users
  def create
    # Sign-up Param => params => user => user.save
    @user = User.new(user_params)
    if @user.save
      # => Success / alert-success
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # => GET /users/:id

    else
      # => Failure
      render 'new', status: :unprocessable_entity
    end

  end


  private

  # Strong Parameters
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation)
  end

  
end
