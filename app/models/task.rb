class Task < ActiveRecord::Base
  attr_accessible :email, :priority, :todo
end
