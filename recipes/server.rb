id = 'latest-mysql'
include_recipe "#{id}::client"

helper = ::ChefCookbook::LatestMySQL.new(node)

mysql_service node[id]['service_name'] do
  version node[id]['version']
  bind_address helper.server_address
  port helper.server_port
  initial_root_password helper.root_password
  action [:create, :start]
end

mysql_config node[id]['service_name'] do
  source 'custom.cnf.erb'
  variables(
    sql_mode: node[id]['config']['sql_mode']
  )
  notifies :restart, "mysql_service[#{node[id]['service_name']}]"
  action :create
end

mysql_connection_info = {
  socket: "/var/run/mysql-#{node[id]['service_name']}/mysqld.sock",
  username: helper.root_username,
  password: helper.root_password
}

node[id]['remote_administration'].each do |remote_user, hosts|
  hosts.each do |host|
    mysql_database_user "#{remote_user}@#{host}" do
      connection mysql_connection_info
      username remote_user
      password helper.password(remote_user)
      host host
      grant_option true
      privileges [:all]
      action [:create, :grant]
    end
  end
end
