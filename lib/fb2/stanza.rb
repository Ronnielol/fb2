module Fb2
  class Stanza < Type
    attribute :id, String
    attribute :text, Array[Text]
    attribute :lang, String
  end
end
