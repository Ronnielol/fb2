module Fb2
  class TitleInfo < Type
    attribute :genres, Array[Genre]#maxOccurs="unbounded">...</xs:element>
    attribute :author, Author#maxOccurs="unbounded">...</xs:element>
    attribute :book_title, String#type="textFieldType">...</xs:element>
    attribute :annotation, String#type="annotationType" minOccurs="0">...</xs:element>
    attribute :keywords, String#type="textFieldType" minOccurs="0">...</xs:element>
    attribute :date, Date#type="dateType" minOccurs="0">...</xs:element>
    attribute :coverpage, Array[Image]#minOccurs="0">...</xs:element>
    attribute :lang, Lang#type="xs:language"/>
    attribute :src_lang, Lang#type="xs:language" minOccurs="0">...</xs:element>
    attribute :translator, Author#type="authorType" minOccurs="0" maxOccurs="unbounded">...</xs:element>
    attribute :sequence, String#type="sequenceType" minOccurs="0" maxOccurs="unbounded">...</xs:element>
  end
end