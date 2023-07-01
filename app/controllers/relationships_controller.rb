class RelationshipsController < ApplicationController
  before_action :logged_in_user

  # POST /relationships
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.turbo_stream   # => app/views/relationships/create.turbo_stream.erb
    end
  end

  # DELETE /relationship/:id
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user, status: :see_other }
      format.turbo_stream   # => app/views/relationships/destroy.turbo_stream.erb
    end
  end
end
