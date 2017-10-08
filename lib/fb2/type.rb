module Fb2
  class Type
    include Virtus.model(nullify_blank: true, strict: true, required: false)
  end
end
