# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # *-------------------- Associations --------------------
  # A owner(user) has many tasks
  has_many :owned_tasks, class_name: 'Task', foreign_key: 'owner_id' # Here in order to retrieve to correct values on ->
  # -> an Active record query....we have to specify the class_name and the foreign_key

  # A user can participate in many tasks.
  has_many :participations, class_name: 'Participant' # Here we have to specify the model class name
  has_many :tasks, through: :participations
  # *------------------- Associations --------------------
end
