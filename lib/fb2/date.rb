module Fb2
  class Date < Type
    attribute :lang, String
    attribute :value, String
    attribute :text, Array[Text]
  end
end