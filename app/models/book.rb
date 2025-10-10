class Book < ApplicationRecord
  belongs_to :list

  validates :title, presence: true

  def has_half_chapter?
    (self.chaptersRead % 1) == 0.5
  end

  def increment_chapter
    if has_half_chapter?
      self.chaptersRead += 0.5
    else
      self.chaptersRead += 1
    end
    self.updated_at = Time.current
    save
  end
end
