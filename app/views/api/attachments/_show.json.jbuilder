includes ||= []

json.id attachment.id
json.thumb attachment.attachment.url(:thumb)
json.small attachment.attachment.url(:small)
json.medium attachment.attachment.url(:medium)
json.large attachment.attachment.url(:large)
json.xlarge attachment.attachment.url(:xlarge)
json.xxlarge attachment.attachment.url(:xxlarge)

if includes.include?(:attachable)
  json.attachable attachment.attachable, partial: "/api/#{attachment.attachable_type.downcase.pluralize}/show", as: attachment.attachable_type.downcase
end