ActionController::Routing::Routes.draw do |map|
# The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  
  #Active RBAC special rote
  map.connect '/registration/confirm/:user/:token',:controller => 'active_rbac/registration', :action => 'confirm'
  map.connect '/access/login',:controller => 'active_rbac/login', :action => 'login'
  map.connect '/access/logout',:controller => 'active_rbac/login', :action => 'logout'
  map.connect '', :controller => "devices"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
end
