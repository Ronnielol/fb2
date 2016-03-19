module Fb2
  class Stanza < Type
    attribute :id#" type="pType" maxOccurs="unbounded">
    attribute :text_author#" type="pType" maxOccurs="unbounded">
    attribute :title#" type="titleType" minOccurs="0"/>
    attribute :subtitle#" type="pType" minOccurs="0"/>
    attribute :text, Array[TextNode]
    # xml:lang
  end
end
