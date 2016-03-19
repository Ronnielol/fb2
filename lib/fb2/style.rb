module Fb2
  class Style < Type
    attribute :name, String
    attribute :lang, String
    attribute :text, Array[Text]
  end
end
