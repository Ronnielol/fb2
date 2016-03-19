module Fb2
  class Paragraph < Type
    attribute :id, String
    attribute :style, String
    attribute :lang, String
    attribute :text, Array[Text]
  end
end
