class User < ActiveRecord::Base
    has_many :assignments
    has_secure_password
end