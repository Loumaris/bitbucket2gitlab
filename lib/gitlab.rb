require 'json'
require 'rest-client'

class Gitlab

  # pass token and url to class
  def initialize(token, url)
    @token = token
    @url = url
  end

  # create project group as namespace and return the id of it
  def create_group(path, name)
    puts "creating #{name} on path #{path}"
    
    ret = RestClient.post "#{@url}/groups", 
                          { path: path, name: name }, 
                          { "Private-Token": @token }     
    json = JSON.parse(ret.body)

    json['id']
  end

  # create new repo in namespace and import old git
  def import(namespace_id, name, path, git)
    puts "importing #{name} into namespace with id #{namespace_id}"
  
    RestClient.post "#{@url}/projects",
                    { name: name, namespace_id: namespace_id, path: path, import_url: git }, 
                    { "Private-Token": @token }
  end

  private 

  # get id for namespace
  def id_of_namespace(namespace)
    ret = RestClient.get "#{@url}/namespaces?search=#{namespace}", 
                          { "Private-Token": @token}
    json = JSON.parse(ret.body)

    json[0]['id']
  end

end