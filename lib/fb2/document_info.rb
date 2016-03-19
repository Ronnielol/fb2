module Fb2
  class DocumentInfo < Type
    attribute :id, String
    attribute :author, Author
    attribute :program_used, String
    attribute :date, Fb2::Date
    attribute :src_url, String
    attribute :src_ocr, String
    attribute :version, String
    attribute :history, Annotation
  end
end
