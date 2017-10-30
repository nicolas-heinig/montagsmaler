def login_as_admin
  login_as(FactoryGirl.create(:admin_user))
end
