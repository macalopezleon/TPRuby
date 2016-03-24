class Cancha < ActiveRecord::Base
  has_many :turns

  def full_name
    "#{name} | Size #{size}"
  end
end
