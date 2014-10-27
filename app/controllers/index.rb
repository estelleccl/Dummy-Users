get '/' do
  # Look in app/views/index.erb
  erb :index

end

post '/login' do 
   if User.authenticate(params[:username], params[:password])
     puts "true"
      erb :index
   else
     puts "false"
     erb :invalid
   end
end




