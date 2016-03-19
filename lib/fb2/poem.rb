module Fb2
  class Poem < Type
    attribute :id, String
    attribute :text, Array[Text]
    attribute :lang, String
  end
end
