module Fb2
  class Binary < Type
    attribute :content_type, String# type="xs:string" use="required"/>
    attribute :id, String# use="required"/>
    attribute :value, String
  end
end