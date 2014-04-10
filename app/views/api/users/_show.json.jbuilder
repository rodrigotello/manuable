includes ||= []

json.id user.id
json.name user.name
json.nickname user.nickname
json.location user.location
json.avatar do |json|
  json.thumb user.avatar.url(:thumb)
  json.small user.avatar.url(:small)
  json.medium user.avatar.url(:medium)
  json.large user.avatar.url(:large)
end
json.state_id user.state_id
json.country_id user.country_id
json.cover_url user.cover.url(:cover)


