module Fb2
  class Text
    include Virtus.value_object

    values do
      attribute :value, String
    end
  end
end
