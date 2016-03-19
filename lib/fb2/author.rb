module Fb2
  class Author < Type
    attribute :first_name, String
    attribute :middle_name, String
    attribute :last_name, String
    attribute :nickname, String
    attribute :home_page, String
    attribute :email, String
  end
end