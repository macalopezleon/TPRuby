require "rails_helper"

describe Turn, :type => :model do

  it "should be created" do
    @user = User.create(
      id: 9999, email: 'prueba@prueba.com', admin: '0', credit: '1', password:'123456'
    )
    @cancha = Cancha.create(
      id: 9999, name: 'canchaPrueba', size: '11'
    )
    @turno = Turn.create(
      user_id: @user.id, cancha_id: @cancha.id, date: '2016-11-22 13:00:00.000000'
    )
    @turno.validate
    expect(@turno).to be_a Turn
  end
  it "should not be created" do
    @user = User.create(
      id: 8888, email: 'prueba@prueba.com', admin: '0', credit: '0', password:'123456'
    )
    @user.save!
    @cancha = Cancha.create(
      id: 8888, name: 'canchaPrueba', size: '11'
    )
    @cancha.save!
    @turno = Turn.create(
      user_id: @user.id, cancha_id: @cancha.id, date: '2016-10-23 13:00:00.000000'
    )
    expect{@turno.save!}.to raise_error
  end

end
