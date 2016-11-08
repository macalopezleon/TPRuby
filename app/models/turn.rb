class Turn < ActiveRecord::Base
  belongs_to :cancha
  belongs_to :user
  validate :validar_creditos

  def validar_creditos
    if self.user.credit <= 0
      errors.add(:el, 'usuario no tiene creditos necesarios')
    end
  end
end
