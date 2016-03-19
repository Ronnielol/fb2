require 'spec_helper'
require 'open-uri'
require 'digest'

describe "integration test" do
  context "https://raw.githubusercontent.com/localhots/fb2/master/test/fixtures/sample.fb2" do
    let(:path) { "https://raw.githubusercontent.com/localhots/fb2/master/test/fixtures/sample.fb2" }
    let(:book) { Fb2::Book.new open(path) }

    describe "#elements" do
      it { expect{ book.elements.to_a }.to_not raise_error }
    end
  end

  context "http://cdn.online-convert.com/example-file/ebook/example.fb2" do
    let(:path) { "https://raw.githubusercontent.com/localhots/fb2/master/test/fixtures/sample.fb2" }
    let(:book) { Fb2::Book.new open(path) }

    describe "#elements" do
      it { expect{ book.elements.to_a }.to_not raise_error }
    end
  end

  context "https://raw.githubusercontent.com/dsdcorp/fb2p/master/example.fb2" do
    let(:path) { "https://raw.githubusercontent.com/localhots/fb2/master/test/fixtures/sample.fb2" }
    let(:book) { Fb2::Book.new open(path) }

    describe "#elements" do
      it { expect{ book.elements.to_a }.to_not raise_error }
    end
  end

  context "http://english-e-reader.net/download\?link\=justice-tim-vicary\&format\=fb2" do
    let(:path) { "https://raw.githubusercontent.com/localhots/fb2/master/test/fixtures/sample.fb2" }
    let(:book) { Fb2::Book.new open(path) }

    describe "#elements" do
      it { expect{ book.elements.to_a }.to_not raise_error }
    end
  end

  context "http://english-e-reader.net/download?link=all-i-want-margaret-johnson&format=fb2" do
    let(:path) { "https://raw.githubusercontent.com/localhots/fb2/master/test/fixtures/sample.fb2" }
    let(:book) { Fb2::Book.new open(path) }

    describe "#elements" do
      it { expect{ book.elements.to_a }.to_not raise_error }
    end
  end

  context "http://english-e-reader.net/download?link=apollos-gold-antoinette-moses&format=fb2" do
    let(:path) { "https://raw.githubusercontent.com/localhots/fb2/master/test/fixtures/sample.fb2" }
    let(:book) { Fb2::Book.new open(path) }

    describe "#elements" do
      it { expect{ book.elements.to_a }.to_not raise_error }
    end
  end

  context "http://english-e-reader.net/download?link=the-amsterdam-connection-sue-leather&format=fb2" do
    let(:path) { "https://raw.githubusercontent.com/localhots/fb2/master/test/fixtures/sample.fb2" }
    let(:book) { Fb2::Book.new open(path) }

    describe "#elements" do
      it { expect{ book.elements.to_a }.to_not raise_error }
    end
  end

  context "http://english-e-reader.net/download?link=the-university-murders-richard-macandrew&format=fb2" do
    let(:path) { "https://raw.githubusercontent.com/localhots/fb2/master/test/fixtures/sample.fb2" }
    let(:book) { Fb2::Book.new open(path) }

    describe "#elements" do
      it { expect{ book.elements.to_a }.to_not raise_error }
    end
  end

  context "http://english-e-reader.net/download?link=management-gurus-david-evans&format=fb2" do
    let(:path) { "https://raw.githubusercontent.com/localhots/fb2/master/test/fixtures/sample.fb2" }
    let(:book) { Fb2::Book.new open(path) }

    describe "#elements" do
      it { expect{ book.elements.to_a }.to_not raise_error }
    end
  end
end
