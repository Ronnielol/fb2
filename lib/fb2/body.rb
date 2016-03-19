module Fb2
  class Body < Type
    attribute :image, Image# minOccurs="0">...</xs:element>
    attribute :title, Title# minOccurs="0">...</xs:element>
    attribute :epigraph, Epigraph# minOccurs="0" maxOccurs="unbounded">...</xs:element>
    attribute :section, Section# maxOccurs="unbounded"/>
    attribute :name, String # (notes)
  end
end
