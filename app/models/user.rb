class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :turns

  def require_admin
    redirect_to '/' if current_user && current_user.admin?
  end

  def canBuy
    !(self.credit.nil?) && (self.credit > 0)
  end

  def remove_credit(credits)
    self.credit=self.credit-credits
    self.save
  end

  def create_credits(credits)
    self.credit=self.credit+credits
    self.save
  end
end
