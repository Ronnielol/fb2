module Fb2
  class Cite < Type
    attribute :id, String
    attribute :text, Array[Text]
    attribute :lang, String
  end
end