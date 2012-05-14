class Post < ActiveRecord::Base
  
  attr_accessible :content, :email, :name, :post_id, :subject, :picture
  before_save :set_name
  before_save :sage
  validates :content, :presence => true
  validates_attachment :picture, 
     :content_type => { :content_type =>  ['image/jpeg', 'image/png']},
     :size => { :in => 0..3.megabytes }

  has_attached_file :picture, 
         :styles => { :small => "150x150>"}
  has_many :comments, :class_name => "Post", :dependent => :destroy
  belongs_to :post, :class_name => "Post", :foreign_key => :post_id 
  scope :threads, where(:post_id => nil).order('updated_at DESC')
  

  protected
    def set_name
      self.name = "Anonymous" if self.name.blank? 
    end

    def sage
      unless self.post_id.nil?
        unless self.email == "sage"
          op_post = Post.find(self.post_id)
          op_post.updated_at = Time.now
          op_post.save
        end  
      end  
    end 
end
