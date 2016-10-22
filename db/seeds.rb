User.create!([
  {admin: true, email: "admin@admin.com", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 4, current_sign_in_at: "2016-10-22 14:59:25", last_sign_in_at: "2016-10-22 00:41:38", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", credit: 0},
  {admin: false, email: "user@user.com", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 4, current_sign_in_at: "2016-10-22 14:59:25", last_sign_in_at: "2016-10-22 00:41:38", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", credit: 0}
])
Buy.create!([
  {credit: 1, idMP: "213389056-0d185689-350b-45e7-9be3-0a74dd2a1d6d", user_id: 1},
  {credit: 1, idMP: "213389056-71994f4c-b5e7-45d7-b734-028bc7e39b42", user_id: 1},

])
Cancha.create!([
  {name: "cancha1", size: 5},
  {name: "cancha2", size: 11},
])
Turn.create!([
])
