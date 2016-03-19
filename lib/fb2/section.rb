module Fb2
  class Section < Type
    attribute :id, String
    attribute :title, String
    attribute :epigraph, Epigraph
    attribute :image, Image
    attribute :annotation, Annotation
    attribute :subsections, Array[Section]
    attribute :text, Array[TextNode]
    # ref lang
  end
end
