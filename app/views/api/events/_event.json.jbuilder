includes ||= []

json.(event, :id, :notes, :benefits, :location_name, :requirements, :name, :description, :address, :spaces, :starts_at, :ends_at, :lat, :lng, :location, :zip, :phone, :city, :municipality)

json.cover event.cover.url(:cover)
json.location_map event.location_map.url(:checkout)

if includes.include?('artisans')
  json.artisans do
    json.partial! '/api/users/show', collection: event.artisans, as: :user
  end
end
