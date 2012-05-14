module PostsHelper
  def model(res = nil)
    if res
      Post.new(:post_id => res.id) 
    else
      Post.new
    end  	
  end
end
