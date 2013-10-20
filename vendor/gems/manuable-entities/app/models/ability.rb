class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)

    can :read, :all

    can :edit, User, id: user.id
    can :manage, Product, user_id: user.id
    can :manage, Attachment do |attachment|
      attachment.attachable.user_id == user.id
    end
  end
end
