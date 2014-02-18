if @access_token.present?
  json.partial! '/api/users/show', user: @user
  json.token @access_token.token
else
  json.http_status '401'
  json.code 'authentication.invalid'
end