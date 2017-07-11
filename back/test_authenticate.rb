require 'rubygems'
require 'net/ldap'

#asasd
	user = "kvargas"
	pwd = "Tangina_01481"

ldap = Net::LDAP.new
ldap.host = 'ed-p-gl.emea.nsn-net.net'
ldap.port = 389

result = ldap.bind_as(
	:base => "o=nsn",
	:filter => "(uid=#{user})",
	:password => pwd
)
if result
	puts "nice one #{result.first.mail}"
else
	puts "luh fail"
end