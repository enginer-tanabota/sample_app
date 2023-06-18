require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with valid email/invalid password" do
    # ログイン用のパスを開く
    get login_path
    # 新規セッションのフォームが正常に表示されることを確認
    assert_template  'sessions/new'
    # ログインエラーを発生させ、ログインできてないことを確認
    post login_path, params: { session: { email:    @user.email,
                                          password: "invalid" } }
    assert_not is_logged_in?
    # 新規セッションのフォームが正しいステータスを返す（sessions/new再表示）
    assert_response  :unprocessable_entity
    assert_template  'sessions/new'
    # フラッシュメッセージが表示される
    assert_not flash.empty?
    # Home画面に遷移
    get root_path
    # Home画面でフラッシュが表示されていないことを確認する
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    
    delete logout_path
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

end
