module Fb2
  class Body < Type
    attribute :name, String
    attribute :text, Array[Text]
    attribute :lang, String
  end
end
