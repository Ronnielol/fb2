module Fb2
  class Style < Type
    attribute :name, String
    attribute :lang, String
    attribute :text, Array[TextNode]
  end
end
