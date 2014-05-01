includes ||= []

json.(conversation, :body, :last_message)

if includes.include?(:from)
  json.from do
    json.partial! '/api/users/show', user: conversation.from
  end
end

if includes.include?(:to)
  json.to do
    json.partial! '/api/users/show', user: conversation.to
  end
end

if includes.include?(:messages)
  json.messages do
    json.partial! '/api/messages/show', collection: conversation.messages
  end
end

if includes.include?(:messages)
  json.messages conversation.messages, partial: '/api/messages/show', as: :message
end

