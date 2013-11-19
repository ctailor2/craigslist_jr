require 'faker'

get '/' do
  # Look in app/views/index.erb
  # @categories = Category.all
  # erb :index
  redirect to('/categories')
end

get '/categories' do
  @categories = Category.all
  erb :index
end

get '/categories/:category_id' do
  @category = Category.find(params[:category_id].to_i)
  @posts = Post.where(:category_id => params[:category_id].to_i)
  erb :posts
end

get '/categories/:category_id/:post_id' do
  @category = Category.find(params[:category_id].to_i)
  @post = Post.find(params[:post_id].to_i)
  erb :post_details
end

get '/create' do
  @categories = Category.all
  erb :create_post
end

post '/create' do
  @category_id = params[:category_id].to_i
  @post = Post.create(category_id: @category_id, title: params[:title], description: params[:description], price: params[:price].to_i, email: params[:email], edit_url: Faker::Lorem.characters(9))
  redirect to("/categories/#{@post.category_id}/#{@post.id}/edit/#{@post.edit_url}")
end

get '/categories/:category_id/:post_id/edit/:edit_url' do
  @categories = Category.all
  @post = Post.find_by_edit_url(params[:edit_url])
  erb :edit_post
end

post '/update/:post_id' do
  @post = Post.find(params[:post_id].to_i)
  Post.update(@post.id, title: params[:title], description: params[:description], price: params[:price].to_i, email: params[:email])
  redirect to("/categories/#{@post.category_id}/#{@post.id}/edit/#{@post.edit_url}")
end


