class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.integer :role
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
