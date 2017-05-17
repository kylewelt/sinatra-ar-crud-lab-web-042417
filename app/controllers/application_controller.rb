require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/posts'
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @post = Post.new(params["posts"])
    if @post.save
      redirect '/'
    else
      redirect '/posts'
    end
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  patch '/posts/:id' do
    @post = Post.find_by(id: params['id'])
    @post.update(params["posts"])
    erb :show
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  delete '/posts/:id/delete' do
    @post = Post.destroy(params['id'])
    erb :delete
  end

end
