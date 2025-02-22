# Dans app/policies/user_policy.rb
class UserPolicy < ApplicationPolicy
  def view_bookings?
    user.portfolio?
  end
end
