module Fb2
  class Book
    def initialize(io, logger = nil)
      @io = io
      @logger = logger || Logger.new(STDOUT)
      @logger.level = ENV['DEBUG'] ? Logger::DEBUG : Logger::INFO
    end

    def elements
      Enumerator.new { |consumer|
        parser = Fb2::Parser.new(@logger) { |element| consumer.yield element }
        Ox.sax_parse(parser, @io.tap(&:rewind))
      }.lazy
    end

    def description
      elements.detect { |element| element.is_a? Description }
    end

    def body
      elements.select { |element| element.is_a? Body }
    end

    alias_method :bodies, :body

    def binary
      elements.select { |element| element.is_a? Binary }
    end

    alias_method :binaries, :binary
  end
end
