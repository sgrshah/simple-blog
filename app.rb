Bundler.require

Dir.glob('./models/*.rb') do |model|
  require model
end

module Blog
	class App < Sinatra::Application
		helpers do
			def title
		    if @title
		      "#{@title} -- My Blog"
		    else
		      "My Blog"
		    end
			end
			def pretty_date(time)
   			time.strftime("%d %b %Y")
  		end
  		def post_show_page?
    		request.path_info =~ /\/posts\/\d+$/
  		end
  		def delete_post_button(post_id)
    		erb :_delete_post_button, locals: { post_id: post_id}
  		end
		end

		get '/' do
  		@posts = Post.order("created_at DESC")
  		erb :'posts/index'
		end

		get '/posts/new' do
			@title = "New Post"
			@post = Post.new
			erb :'posts/new'
		end

		get '/posts/:id' do
			@post = Post.find(params[:id])
			erb :'posts/show'
		end

		post '/posts' do
			@post = Post.new(params[:post])
			if @post.save
				redirect "posts/#{@post.id}"
			else
				erb :'posts/new'
			end
		end

		put '/posts/:id' do
			@post = Post.find(params[:id])
			# @post.title = params[:title]
			# @post.body = params[:body]
			# if @post.save
			if @post.update_attributes(params[:post])
    		redirect "/posts/#{@post.id}"
			else
				erb :'posts/edit'
			end
		end

		get '/posts/:id/edit' do 
			@title = "Edit form"
			@post = Post.find(params[:id])
			erb :'posts/edit'
		end

		delete '/posts/:id' do
			Post.find(params[:id]).destroy
			redirect "/"
		end
	
	end
end

