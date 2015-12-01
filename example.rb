load 'lib/chicrime.rb'

c = Chicrime::Dataset.new

#results = c.client.get(c.dataset_id, {"$where" => "year = 2014 AND ward = 15",
#                                      "$order" => "id DESC",
#                                      "$select" => "ward, id, year",
#                                      "$limit" => "6"})

#results = c.where("year = 2014 AND ward = 15").order(:id, :desc).select(:ward, :id, :year).limit(6).results

results = 
  
c.query do

  where do
    year equals 2014
    ward equals 15
  end

  order :id, :desc
  limit 1
end

puts results
