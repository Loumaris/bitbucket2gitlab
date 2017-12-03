require 'dotenv/load'
require './lib/bitbucket'
require './lib/gitlab'

# run a task on default
task default: %w[import]

namespace :import do 

  task :projects do
    bitbucket = Bitbucket.new(ENV['BITBUCKET_USER'], ENV['BITBUCKET_PASSWORD'], ENV['BITBUCKET_URL'])
    gitlab = Gitlab.new(ENV['GITLAB_TOKEN'], ENV['GITLAB_URL'])

    bitbucket.projects.each do |project|
      # create namespace for project
      namespace_id = gitlab.create_group(project['key'], project['name'])      
      # get all repos and create gitlab projects from it, import them
      bitbucket.repos(project['key']).each do |repo|        
        git_url = bitbucket.git_url(repo['links']['clone'])
        gitlab.import(namespace_id, repo['name'], repo['slug'], git_url)
      end
    end
  end

end

# default task invoke the namespaced import task
task :import do
  Rake::Task['import:projects'].invoke
end