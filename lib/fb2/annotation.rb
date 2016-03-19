module Fb2
  class Annotation < Type
    attribute :id, String
    attribute :text_author, String
    attribute :text, Array[TextNode]
    # lang
  end
end
