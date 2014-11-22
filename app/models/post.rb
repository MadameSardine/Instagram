class Post < ActiveRecord::Base

  has_attached_file :image, styles: { medium: "640x640>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user

  def self.all_in_reverse_order
    all.reverse
  end

  def self.new_with(params)
    create(params)
  end

  def self.remove_with_id(id)
    find(id).destroy
  end
end
