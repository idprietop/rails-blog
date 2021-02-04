class User < ApplicationRecord
    has_secure_password
    has_many :followers, class_name: 'User'
end
