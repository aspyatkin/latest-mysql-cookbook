module ChefCookbook
  class LatestMySQL
    def initialize(node)
      @node = node
      @id = 'latest-mysql'
      @secret = ::ChefCookbook::Secret::Helper.new(node)
    end

    def password(username)
      @secret.get("mysql:password:#{username}")
    end

    def root_username
      @node[@id]['root_username']
    end

    def root_password
      password(root_username)
    end

    def server_address
      @node[@id]['listen']['address']
    end

    def server_port
      @node[@id]['listen']['port']
    end
  end
end
