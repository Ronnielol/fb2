module Fb2
  class Emphasis < Type
    attribute :id, String
    attribute :text, Array[Text]
    attribute :lang, String
  end
end
