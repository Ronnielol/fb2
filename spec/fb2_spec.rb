require 'spec_helper'
require 'open-uri'

describe Fb2::File do
  # let(:path) { File.expand_path("support/example.xml", File.dirname(__FILE__)) }
  let(:path) { 'http://www.gribuser.ru/xml/fictionbook/2.0/example.fb2' }
  let(:file) { Fb2::File.new open(path) }

  # it { expect{ file.elements.lazy.each{ |*| } }.to_not raise_error }
  it { file.elements.each{ |*| } }
end

