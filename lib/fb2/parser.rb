module Fb2
  class Parser < ::Ox::Sax
    include AASM

    aasm do
      state :root, initial: true
      state :fiction_book
      state :stylesheet
      state :description
      state :title_info
      state :genre
      state :author
      state :first_name
      state :middle_name
      state :last_name
      state :nickname
      state :home_page
      state :email
      state :book_title
      state :book_name
      state :annotation
      state :p
      state :empty_line
      state :poem
      state :title
      state :subtitle
      state :epigraph
      state :stanza
      state :v
      state :cite
      state :text_author
      state :a
      state :keywords
      state :date
      state :coverpage
      state :image
      state :lang
      state :src_lang
      state :translator
      state :sequence
      state :document_info
      state :program_used
      state :src_url
      state :src_ocr
      state :id
      state :version
      state :history
      state :publish_info
      state :publisher
      state :city
      state :year
      state :isbn
      state :custom_info
      state :body
      state :section
      state :style
      state :binary
      state :table
      state :tr
      state :th
      state :td

      event :start_fiction_book do
        transitions from: :root, to: :fiction_book
      end

      event :end_fiction_book do
        transitions from: :fiction_book, to: :root
      end

      event :start_stylesheet do
        transitions from: :fiction_book, to: :stylesheet
      end

      event :end_stylesheet do
        transitions from: :stylesheet, to: :fiction_book
      end

      event :start_description do
        transitions from: :fiction_book, to: :description
      end

      event :end_description do
        transitions from: :description, to: :fiction_book
      end

      event :start_title_info do
        transitions from: :description, to: :title_info
      end

      event :end_title_info do
        transitions from: :title_info, to: :description
      end

      event :start_genre do
        transitions from: :title_info, to: :genre
      end

      event :end_genre do
        transitions from: :genre, to: :title_info
      end

      event :start_author do
        transitions from: :title_info, to: :author
        transitions from: :document_info, to: :author
      end

      event :end_author do
        transitions from: :author, to: :title_info, guard: :in_title_info?
        transitions from: :author, to: :document_info, guard: :in_document_info?
      end

      event :start_first_name do
        transitions from: :author, to: :first_name
        transitions from: :translator, to: :first_name
      end

      event :end_first_name do
        transitions from: :first_name, to: :author, guard: :in_author?
        transitions from: :first_name, to: :translator, guard: :in_translator?
      end

      event :start_middle_name do
        transitions from: :author, to: :middle_name
        transitions from: :translator, to: :middle_name
      end

      event :end_middle_name do
        transitions from: :middle_name, to: :author, guard: :in_author?
        transitions from: :middle_name, to: :translator, guard: :in_translator?
      end

      event :start_last_name do
        transitions from: :author, to: :last_name
        transitions from: :translator, to: :last_name
      end

      event :end_last_name do
        transitions from: :last_name, to: :author, guard: :in_author?
        transitions from: :last_name, to: :translator, guard: :in_translator?
      end

      event :start_nickname do
        transitions from: :author, to: :nickname
        transitions from: :translator, to: :nickname
      end

      event :end_nickname do
        transitions from: :nickname, to: :author, guard: :in_author?
        transitions from: :nickname, to: :translator, guard: :in_translator?
      end

      event :start_home_page do
        transitions from: :author, to: :home_page
        transitions from: :translator, to: :home_page
      end

      event :end_home_page do
        transitions from: :home_page, to: :author, guard: :in_author?
        transitions from: :home_page, to: :translator, guard: :in_translator?
      end

      event :start_email do
        transitions from: :author, to: :email
        transitions from: :translator, to: :email
      end

      event :end_email do
        transitions from: :email, to: :author, guard: :in_author?
        transitions from: :email, to: :translator, guard: :in_translator?
      end

      event :start_book_title do
        transitions from: :title_info, to: :book_title
      end

      event :end_book_title do
        transitions from: :book_title, to: :title_info
      end

      event :start_annotation do
        transitions from: :title_info, to: :annotation
      end

      event :end_annotation do
        transitions from: :annotation, to: :title_info
      end

      event :start_p do
        transitions from: :annotation, to: :p
        transitions from: :title, to: :p
        transitions from: :subtitle, to: :p
        transitions from: :epigraph, to: :p
        transitions from: :cite, to: :p
        transitions from: :history, to: :p
        transitions from: :section, to: :p
      end

      event :end_p do
        transitions from: :p, to: :annotation, guard: :in_annotation?
        transitions from: :p, to: :title, guard: :in_title?
        transitions from: :p, to: :subtitle, guard: :in_subtitle?
        transitions from: :p, to: :epigraph, guard: :in_epigraph?
        transitions from: :p, to: :cite, guard: :in_cite?
        transitions from: :p, to: :history, guard: :in_history?
        transitions from: :p, to: :section, guard: :in_section?
      end

      event :start_empty_line do
        transitions from: :annotation, to: :empty_line
        transitions from: :epigraph, to: :empty_line
        transitions from: :title, to: :empty_line
        transitions from: :subtitle, to: :empty_line
      end

      event :end_empty_line do
        transitions from: :empty_line, to: :annotation, guard: :in_annotation?
        transitions from: :empty_line, to: :epigraph, guard: :in_epigraph?
        transitions from: :empty_line, to: :title, guard: :in_title?
        transitions from: :empty_line, to: :subtitle, guard: :in_subtitle?
      end

      event :start_poem do
        transitions from: :annotation, to: :poem
        transitions from: :section, to: :poem
      end

      event :end_poem do
        transitions from: :poem, to: :annotation, guard: :in_annotation?
        transitions from: :poem, to: :section, guard: :in_section?
      end

      event :start_title do
        transitions from: :poem, to: :title
        transitions from: :body, to: :title
        transitions from: :section, to: :title
      end

      event :end_title do
        transitions from: :title, to: :poem, guard: :in_poem?
        transitions from: :title, to: :body, guard: :in_body?
        transitions from: :title, to: :section, guard: :in_section?
      end

      event :start_subtitle do
        transitions from: :poem, to: :subtitle
        transitions from: :body, to: :subtitle
        transitions from: :section, to: :subtitle
      end

      event :end_subtitle do
        transitions from: :subtitle, to: :poem, guard: :in_poem?
        transitions from: :subtitle, to: :body, guard: :in_body?
        transitions from: :subtitle, to: :section, guard: :in_section?
      end

      event :start_epigraph do
        transitions from: :poem, to: :epigraph
        transitions from: :section, to: :epigraph
      end

      event :end_epigraph do
        transitions from: :epigraph, to: :poem, guard: :in_poem?
        transitions from: :epigraph, to: :section, guard: :in_section?
      end

      event :start_stanza do
        transitions from: :poem, to: :stanza
      end

      event :end_stanza do
        transitions from: :stanza, to: :poem
      end

      event :start_v do
        transitions from: :stanza, to: :v
      end

      event :end_v do
        transitions from: :v, to: :stanza
      end

      event :start_cite do
        transitions from: :annotation, to: :cite
      end

      event :end_cite do
        transitions from: :cite, to: :annotation
      end

      event :start_text_author do
        transitions from: :cite, to: :text_author
        transitions from: :epigraph, to: :text_author
      end

      event :end_text_author do
        transitions from: :text_author, to: :cite, guard: :in_cite?
        transitions from: :text_author, to: :epigraph, guard: :in_epigraph?
      end

      event :start_a do
        transitions from: :p, to: :a
      end

      event :end_a do
        transitions from: :a, to: :p
      end

      event :start_keywords do
        transitions from: :title_info, to: :keywords
      end

      event :end_keywords do
        transitions from: :keywords, to: :title_info
      end

      event :start_date do
        transitions from: :title_info, to: :date
        transitions from: :document_info, to: :date
      end

      event :end_date do
        transitions from: :date, to: :title_info, guard: :in_title_info?
        transitions from: :date, to: :document_info, guard: :in_document_info?
      end

      event :start_coverpage do
        transitions from: :title_info, to: :coverpage
      end

      event :end_coverpage do
        transitions from: :coverpage, to: :title_info
      end

      event :start_image do
        transitions from: :coverpage, to: :image
        transitions from: :body, to: :image
      end

      event :end_image do
        transitions from: :image, to: :coverpage, guard: :in_coverpage?
        transitions from: :image, to: :body, guard: :in_body?
      end

      event :start_lang do
        transitions from: :title_info, to: :lang
      end

      event :end_lang do
        transitions from: :lang, to: :title_info
      end

      event :start_src_lang do
        transitions from: :title_info, to: :src_lang
      end

      event :end_src_lang do
        transitions from: :src_lang, to: :title_info
      end

      event :start_translator do
        transitions from: :title_info, to: :translator
      end

      event :end_translator do
        transitions from: :translator, to: :title_info
      end

      event :start_sequence do
        transitions from: :title_info, to: :sequence
      end

      event :end_sequence do
        transitions from: :sequence, to: :title_info
      end

      event :start_document_info do
        transitions from: :description, to: :document_info
      end

      event :end_document_info do
        transitions from: :document_info, to: :description
      end

      event :start_program_used do
        transitions from: :document_info, to: :program_used
      end

      event :end_program_used do
        transitions from: :program_used, to: :document_info
      end

      event :start_src_url do
        transitions from: :document_info, to: :src_url
      end

      event :end_src_url do
        transitions from: :src_url, to: :document_info
      end

      event :start_src_ocr do
        transitions from: :document_info, to: :src_ocr
      end

      event :end_src_ocr do
        transitions from: :src_ocr, to: :document_info
      end

      event :start_id do
        transitions from: :document_info, to: :id
      end

      event :end_id do
        transitions from: :id, to: :document_info
      end

      event :start_version do
        transitions from: :document_info, to: :version
      end

      event :end_version do
        transitions from: :version, to: :document_info
      end

      event :start_history do
        transitions from: :document_info, to: :history
      end

      event :end_history do
        transitions from: :history, to: :document_info
      end

      event :start_publish_info do
        transitions from: :description, to: :publish_info
      end

      event :end_publish_info do
        transitions from: :publish_info, to: :description
      end

      event :start_book_name do
        transitions from: :publish_info, to: :book_name
      end

      event :end_book_name do
        transitions from: :book_name, to: :publish_info
      end

      event :start_publisher do
        transitions from: :publish_info, to: :publisher
      end

      event :end_publisher do
        transitions from: :publisher, to: :publish_info
      end

      event :start_city do
        transitions from: :publish_info, to: :city
      end

      event :end_city do
        transitions from: :city, to: :publish_info
      end

      event :start_year do
        transitions from: :publish_info, to: :year
      end

      event :end_year do
        transitions from: :year, to: :publish_info
      end

      event :start_isbn do
        transitions from: :publish_info, to: :isbn
      end

      event :end_isbn do
        transitions from: :isbn, to: :publish_info
      end

      event :start_custom_info do
        transitions from: :description, to: :custom_info
      end

      event :end_custom_info do
        transitions from: :custom_info, to: :description
      end

      event :start_body do
        transitions from: :fiction_book, to: :body
      end

      event :end_body do
        transitions from: :body, to: :fiction_book
      end

      event :start_section do
        transitions from: :body, to: :section
        transitions from: :section, to: :section
      end

      event :end_section do
        transitions from: :section, to: :body, guard: :in_body?
      end

      event :start_style do
        transitions from: :p, to: :style
      end

      event :end_style do
        transitions from: :style, to: :p
      end

      event :start_binary do
        transitions from: :fiction_book, to: :binary
      end

      event :end_binary do
        transitions from: :binary, to: :fiction_book
      end

      event :start_table do
        transitions from: :section, to: :table
        transitions from: :paragraph, to: :table
      end

      event :end_table do
        transitions from: :table, to: :section, guard: :in_section?
        transitions from: :table, to: :paragraph, guard: :in_paragraph
      end

      event :start_tr do
        transitions from: :table, to: :tr
      end

      event :end_tr do
        transitions from: :tr, to: :table
      end

      event :start_th do
        transitions from: :tr, to: :th
      end

      event :end_th do
        transitions from: :th, to: :tr
      end

      event :start_td do
        transitions from: :tr, to: :td
      end

      event :end_td do
        transitions from: :td, to: :tr
      end
    end

    aasm.states.map(&:name).each do |state_name|
      define_method "in_#{ state_name }?" do
        path[-2] == state_name.to_s
      end
    end

    def initialize(logger, &consumer)
      @consumer = consumer
      @logger = logger
    end

    def start_element(name)
      debug "> #{ name }"

      uname = normalize(name)

      case uname
      when "fiction_book"
        #
      when "stylesheet"
        self.current_element = Stylesheet.new
      when "description"
        self.current_element = Description.new
      when "title_info"
        self.current_element = TitleInfo.new
      when "genre"
        self.current_element = Genre.new
      when "author", "translator"
        self.current_element = Author.new
      when "annotation", "history"
        self.current_element = Annotation.new
      when "p"
        self.current_element = Paragraph.new
      when "empty_line"
        self.current_element = EmptyLine.new
      when "poem"
        self.current_element = Poem.new
      when "title"
        self.current_element = Title.new
      when "subtitle"
        self.current_element = Title.new
      when "epigraph"
        self.current_element = Epigraph.new
      when "stanza"
        self.current_element = Stanza.new
      when "v"
        self.current_element = Verse.new
      when "cite"
        self.current_element = Cite.new
      when "text_author"
        self.current_element = TextAuthor.new
      when "a"
        self.current_element = Anchor.new
      when "date"
        self.current_element = Date.new
      when "coverpage"
        self.current_element = Coverpage.new
      when "image"
        self.current_element = Image.new
      when "lang", "src_lang"
        self.current_element = Lang.new
      when "sequence"
        self.current_element = Sequence.new
      when "document_info"
        self.current_element = DocumentInfo.new
      when "publish_info"
        self.current_element = PublishInfo.new
      when "custom_info"
        self.current_element = CustomInfo.new
      when "body"
        self.current_element = Body.new
      when "section"
        self.current_element = Section.new
      when "style"
        self.current_element = Style.new
      when "binary"
        self.current_element = Binary.new
      when "first_name", "middle_name", "last_name", "nickname", "home_page", "email"
        #
      when "book_title", "book_name"
        #
      when "keywords"
        #
      when "program_used", "src_url", "src_ocr", "id", "version"
        #
      when "publisher", "city", "year", "isbn"
        #
      when "table"
        self.current_element = Table.new
      when "tr"
        self.current_element = Table::Row.new
      when "th"
        self.current_element = Table::Header.new
      when "td"
        self.current_element = Table::Column.new
      else
        fail "undefined element #{ name }"
      end

      path.push uname
      send "start_#{ uname }", name rescue binding.pry
    end

    def end_element(name)
      debug "< #{ name }"
      uname = normalize(name)

      case uname
      when "fiction_book"
        #
      when "stylesheet"
        @consumer.call stack.pop
      when "description"
        @consumer.call stack.pop
      when "body"
        @consumer.call stack.pop
      when "binary"
        @consumer.call stack.pop
      when "title_info"
        self.parent_element.title_info = self.current_element
        stack.pop
      when "document_info"
        self.parent_element.document_info = self.current_element
        stack.pop
      when "custom_info"
        self.parent_element.custom_info = self.current_element
        stack.pop
      when "publish_info"
        self.parent_element.publish_info = self.current_element
        stack.pop
      when "genre"
        self.parent_element.genres << self.current_element
        stack.pop
      when "author"
        self.parent_element.author = self.current_element
        stack.pop
      when "translator"
        self.parent_element.translator = self.current_element
        stack.pop
      when "annotation"
        self.parent_element.annotation = self.current_element
        stack.pop
      when "coverpage"
        self.parent_element.coverpage = self.current_element
        stack.pop
      when "title", "subtitle", "epigraph", "p", "stanza", "empty_line", "poem", "v", "a", "image", "text_author", "cite", "style", "section", "table", "th", "td", "tr"
        self.parent_element.text << self.current_element
        stack.pop
      when "date"
        self.parent_element.date = self.current_element
        stack.pop
      when "sequence"
        self.parent_element.sequence = self.current_element
        stack.pop
      when "history"
        self.parent_element.history = self.current_element
        stack.pop
      when "lang"
        self.parent_element.lang = self.current_element
        stack.pop
      when "src_lang"
        self.parent_element.src_lang = self.current_element
        stack.pop
      when "id", "version", "program_used", "src_url", "src_ocr"
        #
      when "publisher", "city", "year", "isbn", "keywords"
        #
      when "first_name", "middle_name", "last_name", "nickname", "home_page", "email"
        #
      when "book_title", "book_name"
        #
      end

      send "end_#{ uname }", uname unless path[-1] == path[-2] # for section -> section / paragraph -> paragrap
      path.pop
    end

    def attr(name, value)
      debug " #{ name } : #{ value }"
      current_element[normalize name] = value if current_element
    end

    def text(value)
      debug "  text : #{ value }"
      return if value.strip.empty?

      if current_element.respond_to? :text
        current_element.text << Text.new(value: value)
      elsif current_element.respond_to? :value=
        current_element.value = value
      elsif current_element.respond_to? "#{ path.last }="
        current_element.send "#{ path.last }=", value
      else
        fail "undefined behavior for #{ current_element.class.name }##{ path.last } : #{ value }"
      end
    end

    alias_method :cdata, :text

    def stack
      @stack ||= []
    end

    def path
      @path ||= []
    end

    def current_element
      stack[-1]
    end

    def parent_element
      stack[-2]
    end

    def current_element=(value)
      stack.push value
    end

    def debug(message)
      @logger.debug (" " * path.size) << message
    end

    def normalize(string)
      s = string.to_s.split(":").last
      s.gsub!(/::/, '/')
      s.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
      s.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      s.tr!("-", "_")
      s.downcase
    end
  end
end
