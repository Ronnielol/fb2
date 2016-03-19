module Fb2
  class Annotation < Type
    attribute :id, String
    attribute :lang, String
    attribute :text, Array[Text]
  end
end
