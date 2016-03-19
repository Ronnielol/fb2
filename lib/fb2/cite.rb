module Fb2
  class Cite < Type
    attribute :id, String
    attribute :text_author, String
    attribute :text, Array[TextNode]
    # ref lang
  end
end