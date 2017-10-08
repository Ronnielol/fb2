module Fb2
  class Table < Paragraph
    Column = Class.new(Paragraph)
    Header = Class.new(Paragraph)
    Row = Class.new(Paragraph)

    attribute :align, String
  end
end
