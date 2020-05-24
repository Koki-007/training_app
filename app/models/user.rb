class User < ApplicationRecord
  validates :name, presence: {message: "ユーザー名を入力してください"}
  validates :email,
  presence: {message: "メールアドレスを入力してください"},
  uniqueness: {message: "既にこのメールアドレスは使用されています"}
  validates :password, presence: {message: "パスワードを入力してください"}

  def posts
    return Post.where(user_id: self.id)
  end
end
