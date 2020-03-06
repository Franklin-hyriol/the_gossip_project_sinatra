require 'json'

class Gossip
	def initialize(author, content)
		@author = author
		@content = content
	end

	def save 
		file = File.read("./db/gossip.json")
		data = JSON.parse(file)
		data[@author] = @content
		File.write("./db/gossip.json", data.to_json)
	end

	def self.all
		file = File.read("./db/gossip.json")
		data = JSON.parse(file)
		return data
	end

	def self.find(x)
		file = File.read("./db/gossip.json")
		data = JSON.parse(file)
		index_gossip = 1

		data.each do |cle, valeur|
			if index_gossip == x
				return [cle, valeur]
			end
			index_gossip += 1
		end
		return nil
	end

	def self.update(array, id)
		file = File.read("./db/gossip.json")
		data = JSON.parse(file)
		my_array = data.to_a
		my_array[id.to_i] = array
		data_res = my_array.to_h
		File.write("./db/gossip.json", data_res.to_json)
	end
end