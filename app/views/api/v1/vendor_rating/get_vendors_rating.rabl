collection @rating_data

node :vendor_id do |rd|
  rd[:rateable_id]
end

node :rating do |rd|
  rd[:rating]
end