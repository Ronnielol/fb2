module Fb2
  class File
    def initialize(io, logger = nil)
      @io = io
      @logger = logger || Logger.new(STDOUT).tap{ |l| l.level = Logger::DEBUG }
    end

    def elements
      Enumerator.new do |consumer|
        parser = Fb2::Parser.new(@logger) { |element| consumer.yield element }
        Ox.sax_parse(parser, @io.tap(&:rewind))
      end
    end
  end
end
