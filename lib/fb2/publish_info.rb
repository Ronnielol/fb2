module Fb2
  class PublishInfo < Type
    attribute :book_name, String# minOccurs="0">...</xs:element>
    attribute :publisher, String# minOccurs="0">...</xs:element>
    attribute :city, String# minOccurs="0">...</xs:element>
    attribute :year, String# minOccurs="0">...</xs:element>
    attribute :isbn, String# minOccurs="0"/>
    attribute :sequence, Sequence#" minOccurs="0" maxOccurs="unbounded"/>
  end
end
