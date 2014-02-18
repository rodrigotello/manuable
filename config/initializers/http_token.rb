module ActionController
  module HttpAuthentication
    module Token
      def authenticate(controller, &login_procedure)
        token, options = token_and_options(controller.request)
        # original method prevent login_procedure to be call, but we want to handle blank token login at controller level

        # unless token.blank?
          login_procedure.call(token, options)
        # end
      end
    end
  end
end