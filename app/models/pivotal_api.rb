class PivotalApi
  def initialize
    @conn = Faraday.new(:url => 'https://www.pivotaltracker.com')
  end


  def projects(token)
    response = @conn.get do |req|
      req.url "/services/v5/projects"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def stories(token, project_id)
    response = @conn.get do |req|
      req.url "/services/v5/projects/#{project_id}/stories"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end


  # def pivotal_tracker_project_name(pivotal_projects, id)
  #   name = ""
  #   pivotal_projects.each do |project|
  #     if project[:id] == id
  #       name << project[:name]
  #     end
  #   end
  #   name
  # end


end
