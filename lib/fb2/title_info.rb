module Fb2
  class TitleInfo < Type
    attribute :genres, Array[Genre]
    attribute :author, Author
    attribute :book_title, String
    attribute :keywords, String
    attribute :coverpage, Coverpage
    attribute :annotation, Annotation
    attribute :lang, Lang
    attribute :src_lang, Lang
    attribute :translator, Author
    attribute :date, Fb2::Date
    attribute :sequence, Sequence
  end
end