class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }

  def percentage_format
    "#{self.completed_percent.to_i}%"
  end
end
