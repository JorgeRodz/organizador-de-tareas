# frozen_string_literal: true

# class for add abilities to users
class Ability
  include CanCan::Ability

  def initialize(user)
    # owner_id(key) - is the table column name
    # user.id(value) - is the current user id
    can :manage, Task, owner_id: user.id # if the user is the 'task owner' - he have all the CRUD actions ->
    #-> avalibles for her own task

    # * Here we are using the "participating_users" association to check if the user is a participant of the task
    # user_id(key) - is the column name of the table "Participants"
    # user.id(value) - is the current user id
    can :read, Task, participating_users: { user_id: user.id } # if the user is a 'task participant' - he can ->
    #-> only read(show) the task
  end
end
