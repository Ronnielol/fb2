module Fb2
  class Section < Type
    attribute :id, String
    attribute :lang, String
    attribute :text, Array[Text]
  end
end
