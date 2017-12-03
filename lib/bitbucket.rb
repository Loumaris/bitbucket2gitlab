require 'base64'
require 'json'
require 'rest-client'

class Bitbucket

  # pass username, password and url to class
  def initialize(user, password, url)
    @user = user
    @password = password
    @url = url
  end

  # get all projects of the current api user
  def projects
    ret = RestClient.get "#{@url}/projects", 
                          { Authorization: "Basic #{auth_string}"}
    json = JSON.parse(ret.body)

    json['values']
  end

  # get all repos by project key for the current api user
  def repos(project)
    ret = RestClient.get "#{@url}/projects/#{project}/repos", 
                          { Authorization: "Basic #{auth_string}"}
    json = JSON.parse(ret.body)

    json['values']
  end

  # create valid import url (https with username:password auth)
  def git_url(clone_hash)
    git = clone_hash[0]['href'] if clone_hash[0]['name'] == 'http'
    git = clone_hash[1]['href'] if clone_hash[1]['name'] == 'http'

    # inject the password for http auth
    git.sub! @user, "#{@user}:#{@password}"

    git
  end

  private 

  # create http auth header
  def auth_string
    Base64.encode64("#{@user}:#{@password}")
  end

end