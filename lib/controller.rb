require 'gossip'

class ApplicationController < Sinatra::Base
	get '/' do
	  erb :index, locals: {gossips: Gossip.all, index_gossip: 1}
	end

	get '/gossips/new/' do
		erb :new_gossip
	end

	post '/gossips/new/' do
  		gossip = Gossip.new(params["gossip_author"], params["gossip_content"]).save
  		redirect '/'
  	end

  	get "/gossips/:x/" do
 		id = params["x"]
 		find_result = Gossip.find(id.to_i)
		if find_result != nil
			erb :gossip_page, locals: {author: find_result[0], content: find_result[1], id: id}
 		else
 			erb :page_vide, locals: {id: id}
 		end
	end

	get "/edit_gossips/:x/" do
		id = params["x"]
		find_result = Gossip.find(id.to_i)
		erb :edit_gossips, locals: {author: find_result[0], content: find_result[1], id: id}
	end

	post "/edit_gossips/:x/" do
		Gossip.update([params["gossip_author"], params["gossip_content"]], params["x"])
		redirect '/'
	end

end