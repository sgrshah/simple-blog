set :database, "sqlite3:///blog.db"

class Post < ActiveRecord::Base
	validates :title, presence: true, length: { minimum: 3 }
  validates :body, presence: true
end