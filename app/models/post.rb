class Post < ApplicationRecord
  validates :training_type, presence: {message: "トレーニングタイプを選択してください"}
  validates :content, presence: {message: "コメントを入力してください"}
  validates :img, presence: {message: "画像を選択してください"}
  validates :user_id, {presence:true}
  mount_uploader :img, ImgUploader
  def user
    return User.find_by(id: self.user_id)

  end
  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
