module Fb2
  class PublishInfo < Type
    attribute :book_name, String
    attribute :publisher, String
    attribute :city, String
    attribute :year, String
    attribute :isbn, String
    attribute :sequence, Sequence
  end
end
