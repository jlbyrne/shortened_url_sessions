require 'securerandom'
enable :sessions
require 'bcrypt'

get '/' do
  redirect '/profile' if @current_user != nil
  erb :index
end

post '/login' do
  @user_email = params[:email]
  @user_pass = params[:password]
  new_user = User.authenticate(@user_email, @user_pass)
  redirect '/' if new_user == nil
  session[:id] = new_user.id
  redirect '/profile'
end

post '/create_user' do
  created_user = User.create(email: params[:email],username: params[:username], password: params[:password])
  session[:id] = created_user.id
  redirect '/profile'
end


get '/profile' do
  current_user(session[:id])
  redirect '/' if @current_user == nil
  erb :profile
end

post '/logout' do
  session.clear
  redirect '/'
end


def current_user(session_id)
  @current_user = User.find(session_id) if session_id != nil
end


post '/url_maker' do
  @new_url = Url.create(full_url: params[:user_url])
  p "I'm the session id: #{session[:id]}"
  @new_url.add_user_id = session[:id] if session[:id] != nil 
  @short_url = "localhost:9393/#{@new_url.short_url}"
  erb :_confirm_new_url, :layout => false
end

 get '/:short_url' do
    redirect_url = Url.find_by_short_url(params[:short_url]).full_url
    redirect redirect_url
end
