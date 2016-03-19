module Fb2
  class Description < Type
    attribute :title_info, TitleInfo
    attribute :document_info, DocumentInfo
    attribute :publish_info, PublishInfo
    attribute :custom_info, CustomInfo
  end
end