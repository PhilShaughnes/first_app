class Lipsum < ActiveRecord::Base

  validates :name, presence: true#, uniqueness: true
  validates :paragraph, presence: true, uniqueness: true

  def as_json(arg)
    {
      name: name,
      paragraph: paragraph
    }
  end


end
