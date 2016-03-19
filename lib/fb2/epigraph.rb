module Fb2
  class Epigraph < Type
    attribute :id, String
    attribute :text_author, String
    attribute :text, Array[TextNode]
  end
end
