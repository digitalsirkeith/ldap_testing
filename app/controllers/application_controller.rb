class ApplicationController < ActionController::Base
	before_action :authenticate_user!, :except => [:show, :index]
	
	rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
		render :text => exception, :status => 500
	end
	protect_from_forgery with: :exception
end
