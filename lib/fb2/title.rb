module Fb2
  class Title < Type
    attribute :text, Array[Text]
    attribute :lang, String
  end

  Subtitle = Class.new(Title)
end
