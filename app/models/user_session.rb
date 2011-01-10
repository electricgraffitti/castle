class UserSession < Authlogic::Session::Base

  logout_on_timeout true # logout user after set time in User Model config block

  include ActiveModel::Conversion

  def persisted?
    false
  end

  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end

end
