id = 'latest-mysql'

default[id]['listen']['address'] = '127.0.0.1'
default[id]['listen']['port'] = 3306

default[id]['version'] = '5.7'
default[id]['service_name'] = 'default'

default[id]['root_username'] = 'root'
default[id]['remote_administration'] = {}

default[id]['config']['sql_mode'] = nil
