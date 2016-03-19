module Fb2
  class Poem < Type
    attribute :id, String
    attribute :title, String # "titleType" minOccurs="0">...</xs:element>
    attribute :epigraph, Epigraph #" minOccurs="0" maxOccurs="unbounded">...</xs:element>
    attribute :stanza, Stanza # maxOccurs="unbounded">...</xs:element>
    attribute :text_author, String# "textFieldType" minOccurs="0" maxOccurs="unbounded"/>
    attribute :date, Date# "dateType" minOccurs="0">...</xs:element>
    attribute :text, Array[TextNode]# "dateType" minOccurs="0">...</xs:element>
    # xml:lang
  end
end
