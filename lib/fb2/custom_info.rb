module Fb2
  class CustomInfo < Type
    attribute :info_type, String
    attribute :text, Array[Text]
  end
end
