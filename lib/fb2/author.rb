module Fb2
  class Author < Type
    attribute :first_name, String
    attribute :middle_name, String#" minOccurs="0
    attribute :last_name, String
    attribute :nickname, String#" minOccurs="0
    attribute :home_page, String#" minOccurs="0" maxOccurs="unbounded
    attribute :email, String#" minOccurs="0" maxOccurs="unbounded
  end
end