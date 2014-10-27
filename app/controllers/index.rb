enable :sessions
set :home, '/secure/'

def login?
  if session[:username].nil?
    return false
  else
    return true
  end
end

def username
  return session[:username]
end

get '/' do
  # Look in app/views/index.erb

  erb :index
end

post '/login' do 
  @user = User.authenticate(params[:username], params[:password])
   if @user
     session[:username] = @user
     redirect "/secure"
   else
     erb :invalid
   end
end

get '/logout' do
  session[:username] = nil
  redirect "/"
end

get '/signup' do
  erb :signup
end

get '/secure' do
  protected!
  erb :secure
end



