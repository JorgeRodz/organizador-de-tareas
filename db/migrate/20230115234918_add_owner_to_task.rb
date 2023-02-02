class AddOwnerToTask < ActiveRecord::Migration[6.0]
  def change
    # A tasks belongs to an owner(user)
    # null: false -> because a task has to have an owner
    # foreign_key: { to_table: :users } -> because the owner is a user
    # index: true -> because we want to have a better search performance
    add_reference :tasks, :owner, null: false, foreign_key: { to_table: :users }, index: true
  end
end
