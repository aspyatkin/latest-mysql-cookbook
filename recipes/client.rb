id = 'latest-mysql'

mysql_client node[id]['service_name'] do
  version node[id]['version']
  action :create
end

mysql2_chef_gem node[id]['service_name'] do
  package_version node[id]['version']
  action :install
end
