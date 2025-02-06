class Project < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :status_changes, dependent: :destroy

  enum status: { pending: 0, in_progress: 1, completed: 2, archived: 3 }
end
