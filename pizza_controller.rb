require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

#need to connect to where the ruby models are
require_relative("./models/pizza_order")
# or models/*

#so if we make any changes (in models), Sinatra will automatically reload them
also_reload('./models/*')

#returns all the pizza orders
get '/pizza_orders' do
  #at this URL go to the file below
  @orders = PizzaOrder.all()
  #returns an array of all the orders

  erb (:index)
end

#create pizza - needs to be in this order as will not see :id first - the place holder doesn't count
get '/pizza_orders/new' do
  #get data about the user from a form in /new
  erb(:new)
end

post '/pizza_orders/:id/delete' do
  #find the pizza order you want to delete, identified by the id
  @order = PizzaOrder.find(params[:id])
  #when you've found it, delete it.
  @order.delete()
  redirect '/pizza_orders'
  erb(:show)
end

#show one pizza
get '/pizza_orders/:id' do
  #:id is a place holder for the actual id
  @order = PizzaOrder.find(params[:id])
  #params is how we gather in the id from the URL
  erb(:show)
end

#create - send the data from the /new form to the database
post '/pizza_orders' do
  @order = PizzaOrder.new(params)
  @order.save()
  erb(:create)
end

get '/pizza_orders/:id/edit' do
  @order = PizzaOrder.find(params[:id])
  erb(:edit)
end

post '/pizza_orders/:id/edit' do
  @order = PizzaOrder.new(params)
  @order.update()
  erb(:create)
end
