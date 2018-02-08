class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships

  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships


 has_many :usergroups
 has_many :groups,through: :usergroups
 has_many :messages
  def self.search(search) #ここでのself.はUser.を意味する
    if search
      where(['name LIKE ?', "%#{search}%"]) #検索とnameの部分一致を表示。User.は省略
    else
      all #全て表示。User.は省略
    end
  end



def talk_search(current_user)
  talk = nil
  friend_group = self.groups.where(onetoone: "1")
  groups = current_user.groups.where(onetoone: "1")
  friend_group.each do |friend|
    groups.each do |group|
      if friend.id == group.id
          talk = group
          return talk
      end
    end
  end
  return talk
 end

   def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end


  # scope :search, -> (keyword,user_id){ where('name LIKE(?)', "%#{keyword}%").where.not(id: user_id).limit(20) }
end
