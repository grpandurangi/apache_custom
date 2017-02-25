#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

listen_port_attribute = #{node['listen_port']}

package "httpd" do
	 action :install
end

template "/etc/httpd/conf/httpd.conf" do
 source "httpd.conf.erb"
  variables({
    :listen_port => listen_port_attribute
  })
end

cookbook_file "/var/www/html/index.html" do
	source "index.html"
	mode "0644"
end

execute "Disable SELINUX" do 
  user    "root"
  command "setenforce 0"
end

service "httpd" do
	 action [:restart , :enable]
end

service "iptables" do
	 action :stop
end