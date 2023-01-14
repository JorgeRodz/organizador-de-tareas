# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
  has_many :tasks

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true

  # validates_format_of :name, with: /\A[A-Z]/, message: 'El nombre debe comenzar con mayúscula'
end
