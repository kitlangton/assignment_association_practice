class Post < ActiveRecord::Base
  belongs_to :category
  has_many :comments, dependent: :destroy
  # can't do "dependent: :destroy" here b/c there's no primary key on this join table, BUT "dependent: :delete_all" works???

  # ActiveRecord::StatementInvalid: PG::SyntaxError: ERROR:  zero-length delimited identifier at or near """"
  # LINE 1: DELETE FROM "posts_users" WHERE "posts_users"."" = $1

  has_many :post_authorings, class_name: "PostsUser"
  # is the extra SELECT checking for lifecycle callback methods?
  has_many :authors, through: :post_authorings, dependent: :destroy

  has_many :post_taggings, class_name: "Tagging"
  has_many :tags, through: :post_taggings, dependent: :destroy
end
