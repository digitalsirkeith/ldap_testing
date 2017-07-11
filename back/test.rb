require 'rubygems'
require 'net/ldap'

#LDAP Connection Parameters. The auth account should be able to bind to LDAP.  
LDAP_CONNECTION = Net::LDAP.new
LDAP_CONNECTION.host = "ed-p-gl.emea.nsn-net.net"
LDAP_CONNECTION.port = 389
LDAP_CONNECTION.base = "o=nsn"
# LDAP_CONNECTION.auth ""

#Attempt to perform LDAP Bind using Admin Account Above
unless LDAP_CONNECTION.bind 
    msg = LDAP_CONNECTION.get_operation_result.message
    code = LDAP_CONNECTION.get_operation_result.code
    raise "LDAP Connection failed: Message #{msg}, Code: #{code}"
end

#If the LDAP Bind is sucessful, this will return all data from LDAP AD
#Filter parameter is sAMAccountName 

def get_ldap_details(username)
 search_filter = Net::LDAP::Filter.eq("uid", username)
 result = LDAP_CONNECTION.search(:filter => search_filter)
 puts result.inspect
end

#This returns specific attributes from LDAP AD. result_attrs defines those.
# Make sure your AD contains displayName and mail attributes for this to work.  

def get_user_details_from_ldap(username)
	result_attrs = ["uid", "displayName", "mail"]
	search_filter = Net::LDAP::Filter.eq("uid", username)
	LDAP_CONNECTION.search(:filter => search_filter, :attributes => result_attrs) { |item| 
	  puts "#{item.uid.first}: #{item.displayName.first} (#{item.mail.first})" 
	}
	
end

puts get_ldap_details("rjgo")
#puts get_user_details_from_ldap("username")