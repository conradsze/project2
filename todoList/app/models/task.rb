class Task < ActiveRecord::Base
	has_and_belongs_to_many :users
	mount_uploader :image, AvatarUploader

  validates :title, presence: true 
  validates :body, presence: true 
  validates :day, presence: true , :inclusion => { :in => 1..31, :message => "must be between 1 and 31" }
  validates :month, presence: true , :inclusion => { :in => 1..12, :message => "must be between 1 and 12" }
  validates :year, presence: true , :inclusion => { :in => 2000..9999, :message => "is a invalidate number" }
end
