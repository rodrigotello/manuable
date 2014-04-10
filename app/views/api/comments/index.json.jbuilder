@comments.each do |comment|
  json.user do
    json.partial! '/api/users/show', user: @comment.user
  end
end
creator_type: "User"
creator_id: 10
editor_type: nil
editor_id: nil
thread_id: 28
body: "Es blusa o suéter?"
deleted_at: nil
cached_votes_total: 0
cached_votes_up: 0
cached_votes_down: 0
created_at: "2014-01-09 19:43:38"
updated_at: "2014-01-09 19:43:38"