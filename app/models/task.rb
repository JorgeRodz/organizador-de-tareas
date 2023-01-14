# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :string
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :category

  # "validates" allow us to use built in rails validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # "validate" allow us to use custom validations
  validate :due_date_not_in_past

  def due_date_not_in_past
    return if due_date.blank?
    return if due_date > Date.today

    # errors.add() add an error mesage to the object errors collection for the model
    errors.add(:due_date, I18n.t('task.errors.due_date_not_in_past'))
  end
end
