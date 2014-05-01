if @access_token.present?
  json.partial! '/api/users/show', user: @user
  json.email @user.email
  json.token @access_token.token
  json.status 201
else
  json.status 401
  json.code 'authentication.invalid'
end
