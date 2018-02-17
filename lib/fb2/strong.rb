module Fb2
  class Strong < Type
    attribute :id, String
    attribute :text, Array[Text]
    attribute :lang, String
  end
end
