module Fb2
  class Epigraph < Type
    attribute :id, String
    attribute :text, Array[Text]
  end
end
