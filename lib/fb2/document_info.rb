module Fb2
  class DocumentInfo < Type
    attribute :id, String# "xs:token">...</xs:element>
    attribute :author, Author# maxOccurs="unbounded">...</xs:element>
    attribute :program_used, String#"textFieldType" minOccurs="0">...</xs:element>
    attribute :date, Date#"dateType">...</xs:element>
    attribute :src_url, String# "xs:string" minOccurs="0" maxOccurs="unbounded">...</xs:element>
    attribute :src_ocr, String# minOccurs="0">...</xs:element>
    attribute :version, String# "xs:float">...</xs:element>
    attribute :history, Array[TextNode]#"annotationType" minOccurs="0"/>
  end
end
