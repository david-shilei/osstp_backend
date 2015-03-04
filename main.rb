require 'sinatra'
require 'sinatra/reloader'
require 'json'

GlobalState = {}
GlobalState[:ticket] = nil

TicketObject = JSON('{"assigned_to":{"date_joined":"2014-01-07T09:36:04.178945","email":"zlei@vmware.com","first_name":"Lei","groups":[{"id":1,"name":"developers","resource_uri":"/api/v1/group/1/"}],"id":35125,"is_active":true,"is_staff":false,"last_login":"2015-03-03T10:19:07.270441","last_name":"Zhang","profile":{"disable_mail":0,"disabledtext":"","employee_number":"313517","id":35124,"mybugslink":0,"realname":"Lei Zhang 79757","resource_uri":"/api/v1/userprofile/35124/","saved_state":"","sync_exempt":false,"telephone":"+86 21 603 49065","title":"Senior Member of Technical Staff"},"resource_uri":"/api/v1/user/35125/","username":"zlei@vmware.com"},"brief_description":"","cc":[],"creation_ts":"2015-03-03T10:19:25","development_model":"","download_url":"","functionality":"","helps_competitors":"","id":299363,"includes_patents":"---","keywords":[],"last_update_ts":"2015-03-03T10:19:25","legal_contact":null,"license":"---","maintain_project":"","name":"werwrw","nature_of_contribution":"","new_name":"","other_issues":"","parties_of_interest":"","patents_included":"0","precedent":"","project_type":"New","reporter":{"date_joined":"2014-01-07T09:36:04.178945","email":"zlei@vmware.com","first_name":"Lei","groups":[{"id":1,"name":"developers","resource_uri":"/api/v1/group/1/"}],"id":35125,"is_active":true,"is_staff":false,"last_login":"2015-03-03T10:19:07.270441","last_name":"Zhang","profile":{"disable_mail":0,"disabledtext":"","employee_number":"313517","id":35124,"mybugslink":0,"realname":"Lei Zhang 79757","resource_uri":"/api/v1/userprofile/35124/","saved_state":"","sync_exempt":false,"telephone":"+86 21 603 49065","title":"Senior Member of Technical Staff"},"resource_uri":"/api/v1/user/35125/","username":"zlei@vmware.com"},"resolution":"","resource_uri":"/api/v1/contribution/299363/","restrictions":"","status":"NEW","tp_sub_components":"","version":"","vmware_products":""}')

before do
  puts "======================================="
  puts "Params:"
  puts params
  puts "Body:"
  @body = request.body.read
  puts @body
end

post '/api/v1/user/login/' do
  # username and password in request body
  status 200
  headers 'Content-type' => 'application/json'
  body '{"date_joined": "2014-01-07T09:36:04.178945", "email": "zlei@vmware.com", "first_name": "Lei", "groups": [{"id": 1, "name": "developers", "resource_uri": "/api/v1/group/1/"}], "id": 35125, "is_active": true, "is_staff": false, "last_login": "2015-03-03T07:38:47.395279", "last_name": "Zhang", "profile": {"disable_mail": 0, "disabledtext": "", "employee_number": "313517", "id": 35124, "mybugslink": 0, "realname": "Lei Zhang 79757", "resource_uri": "/api/v1/userprofile/35124/", "saved_state": "", "sync_exempt": false, "telephone": "+86 21 603 49065", "title": "Senior Member of Technical Staff"}, "resource_uri": "/api/v1/user/35125/", "username": "zlei@vmware.com"}'
end

get '/api/v1/user/logout/' do
  status 200
  headers 'Content-type' => 'application/json'
  body '{"success": true}'
end

get '/api/v1/user/current_user/' do
  status 200
  headers 'Content-type' => 'application/json'
  body '{"api_key": "a303a70a6139fc72e766214a0abf8128f08b5dad", "date_joined": "2014-01-07T09:36:04.178945", "email": "zlei@vmware.com", "first_name": "Lei", "groups": [{"id": 1, "name": "developers", "resource_uri": "/api/v1/group/1/"}], "id": 35125, "is_active": true, "is_staff": false, "last_login": "2015-03-03T07:38:47.395279", "last_name": "Zhang", "profile": {"disable_mail": 0, "disabledtext": "", "employee_number": "313517", "id": 35124, "mybugslink": 0, "realname": "Lei Zhang 79757", "resource_uri": "/api/v1/userprofile/35124/", "saved_state": "", "sync_exempt": false, "telephone": "+86 21 603 49065", "title": "Senior Member of Technical Staff"}, "resource_uri": "/api/v1/user/35125/", "username": "zlei@vmware.com"}'
end

get '/api/v1/user/35125/users_below_user/' do
  status 200
  headers 'Content-type' => 'application/json'
  body '[35125]'
end

get '/api/v1/useticket/' do
  status 200
  headers 'Content-type' => 'application/json'
  data_str = '{"meta": {"limit": 10, "next": null, "offset": 0, "previous": null, "route": "useticket", "total_count": 0}, "objects": []}'

  data =  load_tickets(data_str)

  data.to_json
end

# get '/api/v1/useticket/schema/' do
#   puts params
#   status 200
#   headers 'Content-type' => 'application/json'
#   body '...'
# end

get '/api/v1/userprofile/35124/' do
  status 200
  headers 'Content-type' => 'application/json'
  body '{"disable_mail": 0, "disabledtext": "", "employee_number": "313517", "id": 35124, "mybugslink": 0, "realname": "Lei Zhang 79757", "resource_uri": "/api/v1/userprofile/35124/", "saved_state": "", "sync_exempt": false, "telephone": "+86 21 603 49065", "title": "Senior Member of Technical Staff"}'
end

put '/api/v1/userprofile/35124/' do
  status 401
end

post '/api/v1/contribution/' do
  puts "params after post params method = #{@body}"
  GlobalState[:ticket] = JSON(@body)
  status 201
end

get '/api/v1/contribution/' do
  # '{"meta": {"limit": 20, "next": null, "offset": 0, "previous": null, "total_count": 0}, "objects": []}'
  body_str ='{"meta": {"limit": 20, "next": null, "offset": 0, "previous": null, "total_count": 1}, "objects": [{"assigned_to": {"date_joined": "2014-01-07T09:36:04.178945", "email": "zlei@vmware.com", "first_name": "Lei", "groups": [{"id": 1, "name": "developers", "resource_uri": "/api/v1/group/1/"}], "id": 35125, "is_active": true, "is_staff": false, "last_login": "2015-03-03T10:19:07.270441", "last_name": "Zhang", "profile": {"disable_mail": 0, "disabledtext": "", "employee_number": "313517", "id": 35124, "mybugslink": 0, "realname": "Lei Zhang 79757", "resource_uri": "/api/v1/userprofile/35124/", "saved_state": "", "sync_exempt": false, "telephone": "+86 21 603 49065", "title": "Senior Member of Technical Staff"}, "resource_uri": "/api/v1/user/35125/", "username": "zlei@vmware.com"}, "brief_description": "", "cc": [], "creation_ts": "2015-03-03T10:19:25", "development_model": "", "download_url": "", "functionality": "", "helps_competitors": "", "id": 299363, "includes_patents": "---", "keywords": [], "last_update_ts": "2015-03-03T10:19:25", "legal_contact": null, "license": "---", "maintain_project": "", "name": "werwrw", "nature_of_contribution": "", "new_name": "", "other_issues": "", "parties_of_interest": "", "patents_included": "0", "precedent": "", "project_type": "New", "reporter": {"date_joined": "2014-01-07T09:36:04.178945", "email": "zlei@vmware.com", "first_name": "Lei", "groups": [{"id": 1, "name": "developers", "resource_uri": "/api/v1/group/1/"}], "id": 35125, "is_active": true, "is_staff": false, "last_login": "2015-03-03T10:19:07.270441", "last_name": "Zhang", "profile": {"disable_mail": 0, "disabledtext": "", "employee_number": "313517", "id": 35124, "mybugslink": 0, "realname": "Lei Zhang 79757", "resource_uri": "/api/v1/userprofile/35124/", "saved_state": "", "sync_exempt": false, "telephone": "+86 21 603 49065", "title": "Senior Member of Technical Staff"}, "resource_uri": "/api/v1/user/35125/", "username": "zlei@vmware.com"}, "resolution": "", "resource_uri": "/api/v1/contribution/299363/", "restrictions": "", "status": "NEW", "tp_sub_components": "", "version": "", "vmware_products": ""}]}'
  
  data = load_tickets(body_str)
  
  body data.to_json
end

def load_tickets(body_str)
  data = JSON(body_str)

  ticket = GlobalState[:ticket]
  if ticket
    puts ticket.inspect
    new_ticket = TicketObject.merge(ticket)
    data["objects"] = [new_ticket]
  else
  end
  
  data
end