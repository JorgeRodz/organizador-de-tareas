# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  code        :string
#  description :string
#  due_date    :date
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  owner_id    :bigint           not null
#
# Indexes
#
#  index_tasks_on_category_id  (category_id)
#  index_tasks_on_owner_id     (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (owner_id => users.id)
#
class Task < ApplicationRecord
  # //-------------------- Associations --------------------
  has_many :notes

  belongs_to :category

  # The 'owner' is a user, so we need to specify the class_name of the model
  belongs_to :owner, class_name: 'User'

  # A task can have many participants
  has_many :participating_users, class_name: 'Participant' # Here we have to specify the model class name
  has_many :participants, through: :participating_users, source: :user # When using the option "through"....we can't ->
  # -> use the "class_name" option instead we use the "source" option
  # //-------------------- Associations --------------------

  # //-------------------- Validations --------------------
  # note: "validates" allow us to use built in rails validations

  # NOTE: We can also validates associations
  validates :participating_users, presence: true

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # To allow the creation of nested attributes for the associated model
  # we need to use the method "accepts_nested_attributes_for"
  # The option "allow_destroy" allow us to delete the associated model if we delete a participating user...the task ->
  # -> will not show up as a participant anymore.
  accepts_nested_attributes_for :participating_users, allow_destroy: true

  # *----- Custom validations
  # note: "validate" allow us to use custom validations
  validate :due_date_not_in_past

  def due_date_not_in_past
    return if due_date.blank?
    return if due_date > Date.today

    # errors.add() add an error message to the object errors collection for the model
    errors.add(:due_date, I18n.t('task.errors.due_date_not_in_past'))
  end

  # *----- Custom validations
  # //-------------------- Validations --------------------

  # //-------------------- Callbacks --------------------
  # Callbacks are always define after the validations
  before_create :create_code
  after_create :send_email
  # //-------------------- Callbacks --------------------

  # //-------------------- Methods --------------------
  def create_code
    self.code = "#{owner_id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(8)}"
  end

  # This function/method will be trigger the mailer
  def send_email
    # As we know the 'participants' is an array so we just add the 'owner' to it. And then loop the array and send a ->
    #-> email to each of them.
    (participants + [owner]).each do |user|
      ParticipantMailer.with(user: user, task: self).new_task_email.deliver! # trigger the mailer
    end
  end
end
