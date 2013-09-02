class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  authenticates_with_sorcery!
end
