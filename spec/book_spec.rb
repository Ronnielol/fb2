require 'spec_helper'
require 'open-uri'
require 'digest'

describe Fb2::Book do
  let(:path) { File.expand_path('support/example.fb2', File.dirname(__FILE__)) }
  let(:book) { Fb2::Book.new open(path) }

  describe '#elements' do
    it { expect { book.elements.to_a }.to_not raise_error }
  end

  specify '#binaries' do
    expect(book.binaries).to be_a(Enumerator)
    expect(book.binaries.count).to eq(2)
    expect(book.binaries.to_a[0]).to be_a(Fb2::Binary)
    expect(book.binaries.to_a[0].id).to eq('tolstoy_port.png')
    expect(book.binaries.to_a[0].content_type).to eq('image/jpeg')
    # на разных версиях руби ломается
    # expect(Digest::MD5.hexdigest(book.binaries.to_a[0].value)).to eq("c55bd0fafdecddc616f98d7bf3060bb1")
  end

  describe '#description' do
    it { expect { book.description }.to_not raise_error }

    describe '#title_info' do
      let(:title_info) { book.description.title_info }

      it { expect { title_info }.to_not raise_error }

      specify '#genres' do
        expect(title_info.genres.map(&:value)).to eq([
                                                       'history_russia',
                                                       'romance_historical',
                                                       'literature_classics',
                                                       'literature_history',
                                                       'literature_war',
                                                       'literature_rus_classsic',
                                                       'computers'
                                                     ])
      end

      describe '#author' do
        it { expect(title_info.author.first_name).to eq('Лев') }
        it { expect(title_info.author.middle_name).to eq('Николаевич') }
        it { expect(title_info.author.last_name).to eq('Толстой') }
        it { expect(title_info.author.nickname).to eq(nil) }
        it { expect(title_info.author.home_page).to eq(nil) }
        it { expect(title_info.author.email).to eq(nil) }
      end

      specify '#book_title' do
        expect(title_info.book_title).to eq('Война и мир')
      end

      specify '#annotation' do
        annotation = book.description.title_info.annotation

        expect(annotation.id).to eq(nil)
        expect(annotation.lang).to eq(nil)
        expect(annotation.text.size).to eq(6)

        expect(annotation.text[0]).to be_a(Fb2::Paragraph)
        expect(annotation.text[0].id).to eq(nil)
        expect(annotation.text[0].style).to eq(nil)
        expect(annotation.text[0].lang).to eq(nil)
        expect(annotation.text[0].text.size).to eq(1)
        expect(annotation.text[0].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[0].text[0].value.split.join(' ')).to eq("Это тестовый файл FictionBook 2.0. Создан Грибовым Дмитрием\n\t\t\t\tв демонстрационных целях и для экспериментов с библиотекой\n\t\t\t\tFIctionBook.lib. К сожалению сам роман я в FB2 пока не перевел.".split.join(' '))

        expect(annotation.text[1]).to be_a(Fb2::EmptyLine)

        expect(annotation.text[2]).to be_a(Fb2::Paragraph)
        expect(annotation.text[2].id).to eq(nil)
        expect(annotation.text[2].style).to eq(nil)
        expect(annotation.text[2].lang).to eq(nil)
        expect(annotation.text[2].text.size).to eq(1)
        expect(annotation.text[2].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[2].text[0].value.split.join(' ')).to eq("Роман Толстого «Война и мир» был написан в 1869 году. Это\n\t\t\t\tпроизведение явилось, по словам многих известных писателей и\n\t\t\t\tкритиков, «величайшим романом в мире». Главная мысль в романе —\n\t\t\t\tмысль народная. Из множества действующих лиц произведения\n\t\t\t\tзначительное место уделено изображению простого люда. Причиной\n\t\t\t\tэтого явилось глубокое понимание и правильная оценка Толстым\n\t\t\t\tрешающей роли народа в исходе войны 1812 года, где полностью\n\t\t\t\tраскрылся «характер русского войска и народа». Немалое место в\n\t\t\t\tромане занимают также картины жизни русского крестьянства. Ведь\n\t\t\t\tв годы создания романа в центре общественного внимания стала\n\t\t\t\tпроблема «мужика».".split.join(' '))

        expect(annotation.text[3]).to be_a(Fb2::Poem)
        expect(annotation.text[3].id).to eq(nil)
        expect(annotation.text[3].lang).to eq(nil)
        expect(annotation.text[3].text.size).to eq(4)

        expect(annotation.text[3].text[0]).to be_a(Fb2::Title)
        expect(annotation.text[3].text[0].text.size).to eq(1)
        expect(annotation.text[3].text[0].text[0]).to be_a(Fb2::Paragraph)
        expect(annotation.text[3].text[0].text[0].id).to eq(nil)
        expect(annotation.text[3].text[0].text[0].style).to eq(nil)
        expect(annotation.text[3].text[0].text[0].lang).to eq(nil)
        expect(annotation.text[3].text[0].text[0].text.size).to eq(1)
        expect(annotation.text[3].text[0].text[0].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[3].text[0].text[0].text[0].value).to eq('Название стиха')

        expect(annotation.text[3].text[1]).to be_a(Fb2::Epigraph)
        expect(annotation.text[3].text[1].id).to eq(nil)
        expect(annotation.text[3].text[1].text.size).to eq(1)
        expect(annotation.text[3].text[1].text[0]).to be_a(Fb2::Paragraph)
        expect(annotation.text[3].text[1].text[0].id).to eq(nil)
        expect(annotation.text[3].text[1].text[0].style).to eq(nil)
        expect(annotation.text[3].text[1].text[0].lang).to eq(nil)
        expect(annotation.text[3].text[1].text[0].text.size).to eq(1)
        expect(annotation.text[3].text[1].text[0].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[3].text[1].text[0].text[0].value).to eq('Стихотворение посвящается тегу "stanza"')

        expect(annotation.text[3].text[2]).to be_a(Fb2::Stanza)
        expect(annotation.text[3].text[2].lang).to eq(nil)
        expect(annotation.text[3].text[2].text.size).to eq(4)

        expect(annotation.text[3].text[2].text[0]).to be_a(Fb2::Verse)
        expect(annotation.text[3].text[2].text[0].id).to eq(nil)
        expect(annotation.text[3].text[2].text[0].style).to eq(nil)
        expect(annotation.text[3].text[2].text[0].lang).to eq(nil)
        expect(annotation.text[3].text[2].text[0].text.size).to eq(1)
        expect(annotation.text[3].text[2].text[0].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[3].text[2].text[0].text[0].value).to eq('Типа тут стихи')

        expect(annotation.text[3].text[2].text[1]).to be_a(Fb2::Verse)
        expect(annotation.text[3].text[2].text[1].id).to eq(nil)
        expect(annotation.text[3].text[2].text[1].style).to eq(nil)
        expect(annotation.text[3].text[2].text[1].lang).to eq(nil)
        expect(annotation.text[3].text[2].text[1].text.size).to eq(1)
        expect(annotation.text[3].text[2].text[1].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[3].text[2].text[1].text[0].value).to eq('В этой строфе')

        expect(annotation.text[3].text[2].text[2]).to be_a(Fb2::Verse)
        expect(annotation.text[3].text[2].text[2].id).to eq(nil)
        expect(annotation.text[3].text[2].text[2].style).to eq(nil)
        expect(annotation.text[3].text[2].text[2].lang).to eq(nil)
        expect(annotation.text[3].text[2].text[2].text.size).to eq(1)
        expect(annotation.text[3].text[2].text[2].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[3].text[2].text[2].text[0].value).to eq('Типа тут стихи')

        expect(annotation.text[3].text[2].text[3]).to be_a(Fb2::Verse)
        expect(annotation.text[3].text[2].text[3].id).to eq(nil)
        expect(annotation.text[3].text[2].text[3].style).to eq(nil)
        expect(annotation.text[3].text[2].text[3].lang).to eq(nil)
        expect(annotation.text[3].text[2].text[3].text.size).to eq(1)
        expect(annotation.text[3].text[2].text[3].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[3].text[2].text[3].text[0].value).to eq('В этой строфе')

        expect(annotation.text[3].text[3]).to be_a(Fb2::Stanza)
        expect(annotation.text[3].text[3].lang).to eq(nil)
        expect(annotation.text[3].text[3].text.size).to eq(4)

        expect(annotation.text[3].text[3].text[0]).to be_a(Fb2::Verse)
        expect(annotation.text[3].text[3].text[0].id).to eq(nil)
        expect(annotation.text[3].text[3].text[0].style).to eq(nil)
        expect(annotation.text[3].text[3].text[0].lang).to eq(nil)
        expect(annotation.text[3].text[3].text[0].text.size).to eq(1)
        expect(annotation.text[3].text[3].text[0].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[3].text[3].text[0].text[0].value).to eq('Здесь по новой стихи')

        expect(annotation.text[3].text[3].text[1]).to be_a(Fb2::Verse)
        expect(annotation.text[3].text[3].text[1].id).to eq(nil)
        expect(annotation.text[3].text[3].text[1].style).to eq(nil)
        expect(annotation.text[3].text[3].text[1].lang).to eq(nil)
        expect(annotation.text[3].text[3].text[1].text.size).to eq(1)
        expect(annotation.text[3].text[3].text[1].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[3].text[3].text[1].text[0].value).to eq('В этой строфе')

        expect(annotation.text[3].text[3].text[2]).to be_a(Fb2::Verse)
        expect(annotation.text[3].text[3].text[2].id).to eq(nil)
        expect(annotation.text[3].text[3].text[2].style).to eq(nil)
        expect(annotation.text[3].text[3].text[2].lang).to eq(nil)
        expect(annotation.text[3].text[3].text[2].text.size).to eq(1)
        expect(annotation.text[3].text[3].text[2].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[3].text[3].text[2].text[0].value).to eq('Обратно стихи стихи')

        expect(annotation.text[3].text[3].text[3]).to be_a(Fb2::Verse)
        expect(annotation.text[3].text[3].text[3].id).to eq(nil)
        expect(annotation.text[3].text[3].text[3].style).to eq(nil)
        expect(annotation.text[3].text[3].text[3].lang).to eq(nil)
        expect(annotation.text[3].text[3].text[3].text.size).to eq(1)
        expect(annotation.text[3].text[3].text[3].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[3].text[3].text[3].text[0].value).to eq('В этой строфе')

        expect(annotation.text[4]).to be_a(Fb2::Cite)
        expect(annotation.text[4].id).to eq(nil)
        expect(annotation.text[4].lang).to eq(nil)
        expect(annotation.text[4].text.size).to eq(2)

        expect(annotation.text[4].text[0]).to be_a(Fb2::Paragraph)
        expect(annotation.text[4].text[0].id).to eq(nil)
        expect(annotation.text[4].text[0].style).to eq(nil)
        expect(annotation.text[4].text[0].lang).to eq(nil)
        expect(annotation.text[4].text[0].text.size).to eq(1)
        expect(annotation.text[4].text[0].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[4].text[0].text[0].value).to eq('Здесь можно кого-нибудь процитировать')

        expect(annotation.text[4].text[1]).to be_a(Fb2::TextAuthor)
        expect(annotation.text[4].text[1].text.size).to eq(1)
        expect(annotation.text[4].text[1].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[4].text[1].text[0].value).to eq('Автор/Источник Цитаты')

        expect(annotation.text[5]).to be_a(Fb2::Paragraph)
        expect(annotation.text[5].id).to eq(nil)
        expect(annotation.text[5].style).to eq(nil)
        expect(annotation.text[5].lang).to eq(nil)
        expect(annotation.text[5].text.size).to eq(3)
        expect(annotation.text[5].text[0]).to be_a(Fb2::Text)
        expect(annotation.text[5].text[0].value.split.join(' ')).to eq("Большую часть романа занимают картины военных действий. В\n\t\t\t\tэтом произведении Толстым дано изображение двух войн: 1805 и\n\t\t\t\t1812 годов. В обеих войнах главным и решающим фактором явились\n\t\t\t\tнародные массы. Особенно большую роль сыграл народ в войне 1812\n\t\t\t\tгода, которая велась в России и была агрессивной, захватнической\n\t\t\t\tсо стороны Франции, но народной, справедливой со стороны России.\n\t\t\t\tПоэтому цель «русского народа была одна: очистить землю от\n\t\t\t\tнашествия». Сознание справедливости своей борьбы придавало\n\t\t\t\tрусским людям огромную силу. Это, прежде всего, видно из\n\t\t\t\tБородинского сражения, где стал понятен «весь смысл и все\n\t\t\t\tзначение этой войны». Бородинская битва, по словам Толстого,\n\t\t\t\tнеобыкновенное, не повторяющееся и не имевшее примеров событие,\n\t\t\t\tи оно есть одно из самых поучительных явлений истории. Писатель\n\t\t\t\tнисколько не сомневался в том, что на Бородинском поле русская\n\t\t\t\tармия одержит победу, которая будет иметь огромные\n\t\t\t\tпоследствия ".split.join(' '))

        expect(annotation.text[5].text[1]).to be_a(Fb2::Anchor)
        expect(annotation.text[5].text[1].href).to eq('#annotation_src')
        expect(annotation.text[5].text[1].type).to eq('note')
        expect(annotation.text[5].text[1].value).to eq('[источник]')

        expect(annotation.text[5].text[2]).to be_a(Fb2::Text)
        expect(annotation.text[5].text[2].value.split.join(' ')).to eq(".\n\t\t\t\t".split.join(' '))
      end

      specify '#sequence' do
        expect(title_info.sequence).to be_a(Fb2::Sequence)
        expect(title_info.sequence.lang).to eq(nil)
        expect(title_info.sequence.name).to eq('Детство, Отрочество, Юность')
        expect(title_info.sequence.number).to eq(2)
      end

      specify '#keywords' do
        expect(title_info.keywords.split.join(' ')).to eq("1912, война, роман, отечественная, наполеон, кутузов,\n\t\t\tимператор, политика, нравственность, изыскания, великий, большой,\n\t\t\tфранцузский, родина, патриотизм, личность, роль личности в истории,\n\t\t\tдворянство, свет, власть, безухов, болконский, должное,\n\t\t\tкрепостное право, крепостничество, подвиг, народ".split.join(' '))
      end

      specify '#lang' do
        expect(title_info.lang).to be_a(Fb2::Lang)
        expect(title_info.lang.value).to eq('ru')
      end

      specify '#src_lang' do
        expect(title_info.src_lang).to be_a(Fb2::Lang)
        expect(title_info.src_lang.value).to eq('ru')
      end

      specify '#coverpage' do
        expect(title_info.coverpage).to be_a(Fb2::Coverpage)
        expect(title_info.coverpage.text.size).to eq(1)
        expect(title_info.coverpage.text[0]).to be_a(Fb2::Image)
        expect(title_info.coverpage.text[0].type).to eq(nil)
        expect(title_info.coverpage.text[0].alt).to eq(nil)
        expect(title_info.coverpage.text[0].href).to eq('#cover.jpg')
      end

      describe '#date' do
        it { expect(title_info.date).to be_a(Fb2::Date) }
        it { expect(title_info.date.value).to eq('1869-01-01') }
        it { expect(title_info.date.text.size).to eq(1) }
        it { expect(title_info.date.text[0]).to be_a(Fb2::Text) }
        it { expect(title_info.date.text[0].value).to eq('1863-1869') }
      end

      describe '#translator' do
        let(:translator) { title_info.translator }

        it { expect(translator).to be_a(Fb2::Author) }
        it { expect(translator.first_name).to eq('Вообще-то') }
        it { expect(translator.middle_name).to eq('никакого переводчика нет') }
        it { expect(translator.last_name).to eq('Это так, для примера') }
        it { expect(translator.nickname).to eq(nil) }
        it { expect(translator.home_page).to eq(nil) }
        it { expect(translator.email).to eq(nil) }
      end
    end

    describe '#document_info' do
      let(:document_info) { book.description.document_info }

      it { expect { book.description.document_info }.to_not raise_error }

      describe '#author' do
        it { expect(document_info.author.first_name).to eq(nil) }
        it { expect(document_info.author.middle_name).to eq(nil) }
        it { expect(document_info.author.last_name).to eq(nil) }
        it { expect(document_info.author.nickname).to eq('GribUser') }
        it { expect(document_info.author.home_page).to eq('http://www.gribuser.ru') }
        it { expect(document_info.author.email).to eq('grib@gribuser.ru') }
      end

      specify '#program-used' do
        expect(document_info.program_used).to eq('ClearTXT, XMLSpy, HomeSite 5.0')
      end

      specify '#date' do
        expect(document_info.date).to be_a(Fb2::Date)
        expect(document_info.date.value).to eq('2002-10-15')
        expect(document_info.date.text.size).to eq(1)
        expect(document_info.date.text[0]).to be_a(Fb2::Text)
        expect(document_info.date.text[0].value).to eq('15 ноября 2002г., 19:53')
      end

      specify '#src-url' do
        expect(document_info.src_url).to eq('http://www.magister.msk.ru/library/tolstoy/wp/wp00.htm')
      end

      specify '#src-ocr' do
        expect(document_info.src_ocr).to eq('Oleg E. Kolesnikov')
      end

      specify '#id' do
        expect(document_info.id).to eq('GribUser_WarAndPeace_D49FHSH8l0HS5')
      end

      specify '#version' do
        expect(document_info.version).to eq('2.0')
      end

      specify '#history' do
        expect(document_info.history).to be_a(Fb2::Annotation)
        expect(document_info.history.id).to eq(nil)
        expect(document_info.history.lang).to eq(nil)
        expect(document_info.history.text.size).to eq(1)
        expect(document_info.history.text[0]).to be_a(Fb2::Paragraph)
        expect(document_info.history.text[0].id).to eq(nil)
        expect(document_info.history.text[0].lang).to eq(nil)
        expect(document_info.history.text[0].style).to eq(nil)
        expect(document_info.history.text[0].text.size).to eq(1)
        expect(document_info.history.text[0].text[0]).to be_a(Fb2::Text)
        expect(document_info.history.text[0].text[0].value).to eq('Этот документ первоначально был создан для FictionBook 1.0 и позднее переделан для FB2.0')
      end
    end

    describe '#publish_info' do
      let(:publish_info) { book.description.publish_info }

      it { expect { publish_info }.to_not raise_error }

      specify '#book_name' do
        expect(publish_info.book_name).to eq('Л.Н.Толстой, Полное Собрание Сочинений')
      end

      specify '#publisher' do
        expect(publish_info.publisher).to eq('ГИХЛ')
      end

      specify '#city' do
        expect(publish_info.city).to eq('Москва')
      end

      specify '#year' do
        expect(publish_info.year).to eq('1957')
      end

      specify '#isbn' do
        expect(publish_info.isbn).to eq('Тут пишем ISBN код книги, если есть')
      end
    end

    specify '#custom_info' do
      custom_info = book.description.custom_info
      expect(custom_info.info_type).to eq('general')
      expect(custom_info.text.size).to eq(1)
      expect(custom_info.text[0]).to be_a(Fb2::Text)
      expect(custom_info.text[0].value.split.join(' ')).to eq("\n\t\t\tЗдесь можно расположить дополнительную информацию, не\n\t\t\tукладывающуюся в заданную схему. Это может быть как описательная\n\t\t\tинформация, так и коммерческая информация, связанная с книгой -\n\t\t\tнапример, информация о том, где можно купить бумажное издание\n\t\t".split.join(' '))
    end
  end

  specify '#body' do
    bodies = book.bodies.to_a
    expect(bodies.size).to eq(2)

    expect(bodies[0].lang).to eq(nil)
    expect(bodies[0].name).to eq(nil)
    expect(bodies[0].text.size).to eq(4)

    expect(bodies[0].text[0]).to be_a(Fb2::Image)
    expect(bodies[0].text[0].type).to eq(nil)
    expect(bodies[0].text[0].alt).to eq(nil)
    expect(bodies[0].text[0].href).to eq('#tolstoy_port.png')

    expect(bodies[0].text[1]).to be_a(Fb2::Title)
    expect(bodies[0].text[1].lang).to eq(nil)
    expect(bodies[0].text[1].text.size).to eq(1)
    expect(bodies[0].text[1].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[1].text[0].id).to eq(nil)
    expect(bodies[0].text[1].text[0].lang).to eq(nil)
    expect(bodies[0].text[1].text[0].style).to eq(nil)
    expect(bodies[0].text[1].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[1].text[0].text[0].value).to eq('ТОМ 1')

    expect(bodies[0].text[2]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].id).to eq(nil)
    expect(bodies[0].text[2].lang).to eq(nil)
    expect(bodies[0].text[2].text.size).to eq(5)

    expect(bodies[0].text[2].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[0].text.size).to eq(1)

    expect(bodies[0].text[2].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[0].text[0].text[0].value).to eq('ЧАСТЬ ПЕРВАЯ')

    expect(bodies[0].text[2].text[1]).to be_a(Fb2::Epigraph)
    expect(bodies[0].text[2].text[1].text.size).to eq(4)

    expect(bodies[0].text[2].text[1].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[1].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[1].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[1].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[1].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[1].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[1].text[0].text[0].value.split.join(' ')).to eq('На самом деле тут нет никакого эпиграфа. Эпиграф добавил Грибов Дмитрий в демонстрационных целях. Тут можно ставить пустые строки:'.split.join(' '))

    expect(bodies[0].text[2].text[1].text[1]).to be_a(Fb2::EmptyLine)

    expect(bodies[0].text[2].text[1].text[2]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[1].text[2].id).to eq(nil)
    expect(bodies[0].text[2].text[1].text[2].lang).to eq(nil)
    expect(bodies[0].text[2].text[1].text[2].style).to eq(nil)
    expect(bodies[0].text[2].text[1].text[2].text.size).to eq(1)
    expect(bodies[0].text[2].text[1].text[2].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[1].text[2].text[0].value.split.join(' ')).to eq('и любое другое форматирование.'.split.join(' '))

    expect(bodies[0].text[2].text[1].text[3]).to be_a(Fb2::TextAuthor)
    expect(bodies[0].text[2].text[1].text[3].text.size).to eq(1)
    expect(bodies[0].text[2].text[1].text[3].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[1].text[3].text[0].value.split.join(' ')).to eq('Грибов Дмитрий'.split.join(' '))

    expect(bodies[0].text[2].text[2]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[2].id).to eq(nil)
    expect(bodies[0].text[2].text[2].lang).to eq(nil)
    expect(bodies[0].text[2].text[2].text.size).to eq(6)
    expect(bodies[0].text[2].text[2].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[2].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[2].text[0].text.size).to eq(1)

    expect(bodies[0].text[2].text[2].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[2].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[2].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[2].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[2].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[2].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[0].text[0].text[0].value).to eq('I')

    expect(bodies[0].text[2].text[2].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[2].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[2].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[2].text[1].style).to eq(nil)
    expect(bodies[0].text[2].text[2].text[1].text.size).to eq(11)
    expect(bodies[0].text[2].text[2].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[1].text[0].value).to eq('- ')
    expect(bodies[0].text[2].text[2].text[1].text[1]).to be_a(Fb2::Style)
    expect(bodies[0].text[2].text[2].text[1].text[1].name).to eq('foreign lang')
    expect(bodies[0].text[2].text[2].text[1].text[1].lang).to eq('fr')
    expect(bodies[0].text[2].text[2].text[1].text[1].text.size).to eq(1)
    expect(bodies[0].text[2].text[2].text[1].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[1].text[1].text[0].value.split.join(' ')).to eq('Еh bien, mon prince. Gênes et Lucques ne sont plus que des apanages, des'.split.join(' '))
    expect(bodies[0].text[2].text[2].text[1].text[2]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[1].text[2].value).to eq(' поместья, ')
    expect(bodies[0].text[2].text[2].text[1].text[3]).to be_a(Fb2::Style)
    expect(bodies[0].text[2].text[2].text[1].text[3].name).to eq('foreign lang')
    expect(bodies[0].text[2].text[2].text[1].text[3].lang).to eq('fr')
    expect(bodies[0].text[2].text[2].text[1].text[3].text.size).to eq(1)
    expect(bodies[0].text[2].text[2].text[1].text[3].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[1].text[3].text[0].value.split.join(' ')).to eq("de la famille Buonaparte. Non, je vous préviens, que si vous ne me dites pas, que nous avons la guerre, si vous vous permettez encore de pallier toutes les infamies, toutes les atrocités de cet Antichrist (ma parole, j'y crois) -- je ne vous connais plus, vous n'êtes plus mon ami, vous n'êtes plus".split.join(' '))
    expect(bodies[0].text[2].text[2].text[1].text[4]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[1].text[4].value).to eq(' мой верный раб, ')
    expect(bodies[0].text[2].text[2].text[1].text[5]).to be_a(Fb2::Style)
    expect(bodies[0].text[2].text[2].text[1].text[5].name).to eq('foreign lang')
    expect(bodies[0].text[2].text[2].text[1].text[5].lang).to eq('fr')
    expect(bodies[0].text[2].text[2].text[1].text[5].text.size).to eq(1)
    expect(bodies[0].text[2].text[2].text[1].text[5].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[1].text[5].text[0].value).to eq('comme vous dites')
    expect(bodies[0].text[2].text[2].text[1].text[6]).to be_a(Fb2::Anchor)
    expect(bodies[0].text[2].text[2].text[1].text[6].href).to eq('#note_1')
    expect(bodies[0].text[2].text[2].text[1].text[6].type).to eq('note')
    expect(bodies[0].text[2].text[2].text[1].text[6].value).to eq('1')
    expect(bodies[0].text[2].text[2].text[1].text[7]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[1].text[7].value.split.join(' ')).to eq('. Ну, здравствуйте, здравствуйте.'.split.join(' '))
    expect(bodies[0].text[2].text[2].text[1].text[8]).to be_a(Fb2::Style)
    expect(bodies[0].text[2].text[2].text[1].text[8].name).to eq('foreign lang')
    expect(bodies[0].text[2].text[2].text[1].text[8].lang).to eq('fr')
    expect(bodies[0].text[2].text[2].text[1].text[8].text.size).to eq(1)
    expect(bodies[0].text[2].text[2].text[1].text[8].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[1].text[8].text[0].value.split.join(' ')).to eq('Je vois que je vous fais peur'.split.join(' '))
    expect(bodies[0].text[2].text[2].text[1].text[9]).to be_a(Fb2::Anchor)
    expect(bodies[0].text[2].text[2].text[1].text[9].href).to eq('#note_2')
    expect(bodies[0].text[2].text[2].text[1].text[9].type).to eq('note')
    expect(bodies[0].text[2].text[2].text[1].text[9].value).to eq('2')
    expect(bodies[0].text[2].text[2].text[1].text[10]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[1].text[10].value).to eq(', садитесь и рассказывайте.')

    expect(bodies[0].text[2].text[2].text[2]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[2].text[2].id).to eq(nil)
    expect(bodies[0].text[2].text[2].text[2].lang).to eq(nil)
    expect(bodies[0].text[2].text[2].text[2].style).to eq(nil)
    expect(bodies[0].text[2].text[2].text[2].text.size).to eq(5)
    expect(bodies[0].text[2].text[2].text[2].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[2].text[0].value.split.join(' ')).to eq('Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер. Анна Павловна кашляла несколько дней, у нее был '.split.join(' '))
    expect(bodies[0].text[2].text[2].text[2].text[1]).to be_a(Fb2::Style)
    expect(bodies[0].text[2].text[2].text[2].text[1].name).to eq('italic')
    expect(bodies[0].text[2].text[2].text[2].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[2].text[2].text[1].text.size).to eq(1)
    expect(bodies[0].text[2].text[2].text[2].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[2].text[1].text[0].value).to eq('грипп')
    expect(bodies[0].text[2].text[2].text[2].text[2]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[2].text[2].value).to eq(', как она говорила (')
    expect(bodies[0].text[2].text[2].text[2].text[3]).to be_a(Fb2::Style)
    expect(bodies[0].text[2].text[2].text[2].text[3].name).to eq('italic')
    expect(bodies[0].text[2].text[2].text[2].text[3].lang).to eq(nil)
    expect(bodies[0].text[2].text[2].text[2].text[3].text.size).to eq(1)
    expect(bodies[0].text[2].text[2].text[2].text[3].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[2].text[3].text[0].value).to eq('грипп')
    expect(bodies[0].text[2].text[2].text[2].text[4]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[2].text[4].value.split.join(' ')).to eq(' был тогда новое слово, употреблявшееся только редкими). В записочках, разосланных утром с красным лакеем, было написано без различия во всех:'.split.join(' '))

    expect(bodies[0].text[2].text[2].text[3]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[2].text[3].id).to eq(nil)
    expect(bodies[0].text[2].text[2].text[3].lang).to eq('fr')
    expect(bodies[0].text[2].text[2].text[3].style).to eq(nil)
    expect(bodies[0].text[2].text[2].text[3].text.size).to eq(3)
    expect(bodies[0].text[2].text[2].text[3].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[3].text[0].value.split.join(' ')).to eq("\"Si vous n'avez rien de mieux à faire, M. le comte (или mon prince), et si la perspective de passer la soirée chez une pauvre malade ne vous effraye pas trop, je serai charmée de vous voir chez moi entre 7 et 10 heures. Annette Scherer\"".split.join(' '))
    expect(bodies[0].text[2].text[2].text[3].text[1]).to be_a(Fb2::Anchor)
    expect(bodies[0].text[2].text[2].text[3].text[1].href).to eq('#note_3')
    expect(bodies[0].text[2].text[2].text[3].text[1].type).to eq('note')
    expect(bodies[0].text[2].text[2].text[3].text[1].value).to eq('3')
    expect(bodies[0].text[2].text[2].text[3].text[2]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[3].text[2].value.split.join(' ')).to eq(".\n\t\t\t\t".split.join(' '))

    expect(bodies[0].text[2].text[2].text[4]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[2].text[4].id).to eq(nil)
    expect(bodies[0].text[2].text[2].text[4].lang).to eq(nil)
    expect(bodies[0].text[2].text[2].text[4].style).to eq(nil)
    expect(bodies[0].text[2].text[2].text[4].text.size).to eq(4)
    expect(bodies[0].text[2].text[2].text[4].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[4].text[0].value).to eq('- ')
    expect(bodies[0].text[2].text[2].text[4].text[1]).to be_a(Fb2::Style)
    expect(bodies[0].text[2].text[2].text[4].text[1].name).to eq('foreign lang')
    expect(bodies[0].text[2].text[2].text[4].text[1].lang).to eq('fr')
    expect(bodies[0].text[2].text[2].text[4].text[1].text.size).to eq(1)
    expect(bodies[0].text[2].text[2].text[4].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[4].text[1].text[0].value.split.join(' ')).to eq('Dieu, quelle virulente sortie'.split.join(' '))
    expect(bodies[0].text[2].text[2].text[4].text[2]).to be_a(Fb2::Anchor)
    expect(bodies[0].text[2].text[2].text[4].text[2].href).to eq('#note_4')
    expect(bodies[0].text[2].text[2].text[4].text[2].type).to eq('note')
    expect(bodies[0].text[2].text[2].text[4].text[2].value).to eq('4')
    expect(bodies[0].text[2].text[2].text[4].text[3]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[4].text[3].value.split.join(' ')).to eq(' - отвечал, нисколько не смутясь такою встречей, вошедший князь, в придворном, шитом мундире, в чулках, башмаках, при звездах, с светлым выражением плоского лица. Он говорил на том изысканном французском языке, на котором не только говорили, но и думали наши деды, и с теми тихими, покровительственными интонациями, которые свойственны состаревшемуся в свете и при дворе значительному человеку. Он подошел к Анне Павловне, поцеловал ее руку, подставив ей свою надушенную и сияющую лысину, и покойно уселся на диване.'.split.join(' '))

    expect(bodies[0].text[2].text[2].text[5]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[2].text[5].id).to eq(nil)
    expect(bodies[0].text[2].text[2].text[5].lang).to eq(nil)
    expect(bodies[0].text[2].text[2].text[5].style).to eq(nil)
    expect(bodies[0].text[2].text[2].text[5].text.size).to eq(4)
    expect(bodies[0].text[2].text[2].text[5].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[5].text[0].value).to eq('- ')
    expect(bodies[0].text[2].text[2].text[5].text[1]).to be_a(Fb2::Style)
    expect(bodies[0].text[2].text[2].text[5].text[1].name).to eq('foreign lang')
    expect(bodies[0].text[2].text[2].text[5].text[1].lang).to eq('fr')
    expect(bodies[0].text[2].text[2].text[5].text[1].text.size).to eq(1)
    expect(bodies[0].text[2].text[2].text[5].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[5].text[1].text[0].value.split.join(' ')).to eq('Avant tout dites moi, comment vous allez, chère amie?'.split.join(' '))
    expect(bodies[0].text[2].text[2].text[5].text[2]).to be_a(Fb2::Anchor)
    expect(bodies[0].text[2].text[2].text[5].text[2].href).to eq('#note_5')
    expect(bodies[0].text[2].text[2].text[5].text[2].type).to eq('note')
    expect(bodies[0].text[2].text[2].text[5].text[2].value).to eq('5')
    expect(bodies[0].text[2].text[2].text[5].text[3]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[2].text[5].text[3].value.split.join(' ')).to eq(' Успокойте друга, - сказал он, не изменяя голоса и тоном, в котором из-за приличия и участия просвечивало равнодушие и даже насмешка.'.split.join(' '))

    expect(bodies[0].text[2].text[3]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].id).to eq(nil)
    expect(bodies[0].text[2].text[3].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text.size).to eq(5)
    expect(bodies[0].text[2].text[3].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[0].text.size).to eq(1)

    expect(bodies[0].text[2].text[3].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[0].text[0].text[0].value.split.join(' ')).to eq('Это пример глубоко вложенных частей'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[1]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text.size).to eq(4)
    expect(bodies[0].text[2].text[3].text[1].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[1].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[0].text.size).to eq(1)

    expect(bodies[0].text[2].text[3].text[1].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[1].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[1].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[1].text[0].text[0].text[0].value).to eq('Рыба (1.I)')

    expect(bodies[0].text[2].text[3].text[1].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[1].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[1].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[1].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[1].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[1].text[1].text[0].value.split.join(' ')).to eq('Представляется логичным, что искусство индуктивно - это напряженный закон внешнего мира. Преамбула иллюзорна. Постмодернизм может быть получен из опыта. Представление, как принято считать, раскладывает на элементы смысл жизни, условно. Универсальное рефлектирует себя через интеллект.'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[1].text[2]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[1].text[2].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[2].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[2].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[2].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[1].text[2].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[1].text[2].text[0].value.split.join(' ')).to eq('Частное, пренебрегая деталями, философски ассоциирует естественный объект деятельности. Отсюда естественно следует, что акция трансформирует онтологический конфликт. Класс эквивалентности, как следует из вышесказанного, нетривиален. Закон внешнего мира реально осмысляет непредвиденный структурализм. Отношение к современности, конечно, представляет постмодернизм.'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[1].text[3]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[1].text[3].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[3].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[3].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[3].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[1].text[3].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[1].text[3].text[0].value.split.join(' ')).to eq('Искусство решительно означает субъективный интеллект. Надо сказать, что ощущение мира оспособляет типичный мир, изменяя привычную реальность. Наряду с этим конфликт раскладывает на элементы постсовременный класс эквивалентности. Согласно мнению известных философов закон внешнего мира транспонирует примитивный структурализм. Общество, в рамках сегодняшних воззрений, преобразует мир.'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[1].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[1].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[1].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[1].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[1].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[1].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[1].text[0].text[0].text[0].value.split.join(' ')).to eq('Рыба (1.I)'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[2]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].text[2].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text.size).to eq(6)
    expect(bodies[0].text[2].text[3].text[2].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[2].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[0].text.size).to eq(1)

    expect(bodies[0].text[2].text[3].text[2].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[2].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[2].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[2].text[0].text[0].text[0].value.split.join(' ')).to eq('Рыба (1.II)'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[2].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[2].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[1].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[1].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[2].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[2].text[1].text[0].value.split.join(' ')).to eq('Интересно отметить, что врожденная интуиция ментально дискредитирует структурализм, открывая новые горизонты. Созерцание осмысляет трагический конфликт. Современная ситуация вырождена. Интеллект создает данный постмодернизм. Частное подрывает закон внешнего мира. Универсальное трогательно наивно. Объект деятельности, следовательно, ясен не всем. Напряжение, конечно, нетривиально. '.split.join(' '))

    expect(bodies[0].text[2].text[3].text[2].text[2]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[2].text[2].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[2].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[2].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[2].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[2].text[2].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[2].text[2].text[0].value.split.join(' ')).to eq('Смысл жизни неоднозначен. Предметность ассоциирует класс эквивалентности, исходя из принятого мнения. Сомнение индуцирует интеллект. Любовь категорически осмысляет примитивный принцип восприятия.'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[2].text[3]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[2].text[3].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[3].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[3].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[3].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[2].text[3].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[2].text[3].text[0].value.split.join(' ')).to eq('Структурализм оспособляет постсовременный конфликт, изменяя привычную реальность. Поливалентность решительно подрывает субъективный смысл жизни, отрицая очевидное. Реальная власть, пренебрегая деталями, дискредитирует постмодернизм, учитывая известные обстоятельства. Искусство амбивалентно. Класс эквивалентности не так уж очевиден. Философия трансформирует неоднозначный мир. Структурализм - это типичный смысл жизни. Ощущение мира осмысленно фокусирует трагический объект деятельности.'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[2].text[4]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[2].text[4].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[4].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[4].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[4].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[2].text[4].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[2].text[4].text[0].value.split.join(' ')).to eq('Общество подрывает естественный интеллект. Согласно мнению известных философов принцип восприятия непредвзято заполняет постмодернизм. Конфликт может быть получен из опыта. Смысл жизни порождает и обеспечивает структурализм. Класс эквивалентности прост.'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[2].text[5]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[2].text[5].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[5].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[5].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[2].text[5].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[2].text[5].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[2].text[5].text[0].value.split.join(' ')).to eq('Созерцание оспособляет примитивный структурализм, отрицая очевидное. Страсть порождает и обеспечивает непредвиденный класс эквивалентности. Можно предположить, что смысл жизни не так уж очевиден. Закон внешнего мира абстрактен.'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[3]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].text[3].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[3].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[3].text.size).to eq(3)

    expect(bodies[0].text[2].text[3].text[3].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[3].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[3].text[0].text.size).to eq(1)

    expect(bodies[0].text[2].text[3].text[3].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[3].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[3].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[3].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[3].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[3].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[3].text[0].text[0].text[0].value.split.join(' ')).to eq('Рыба (1.III)'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[3].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[3].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[3].text[1].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[3].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[3].text[1].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[3].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[3].text[1].text[0].value.split.join(' ')).to eq('Наряду с этим мир контролирует субъективный структурализм. Свобода ментально рассматривается через принцип восприятия. Представляется логичным, что частное профанирует интеллект. Универсальное создает закон внешнего мира. Согласно предыдущему, современная ситуация ассоциирует паллиативный объект деятельности, изменяя привычную реальность. Предметность подчеркивает смысл жизни, несмотря на мнение авторитетов.'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[3].text[2]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[3].text[2].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[3].text[2].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[3].text[2].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[3].text[2].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[3].text[2].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[3].text[2].text[0].value.split.join(' ')).to eq('Реальность означает принцип восприятия. Интеллект нетривиален. Реальная власть индуцирует сложный закон внешнего мира. Согласно мнению известных философов структурализм, пренебрегая деталями, индуктивно подрывает постмодернизм. Ощущение мира заполняет напряженный класс эквивалентности, учитывая известные обстоятельства. Можно предположить, что врожденная интуиция профанирует объект деятельности.'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[4]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].text[4].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text.size).to eq(5)
    expect(bodies[0].text[2].text[3].text[4].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[4].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[0].text.size).to eq(1)

    expect(bodies[0].text[2].text[3].text[4].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[1]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].text[4].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text.size).to eq(3)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text.size).to eq(1)

    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text.size).to eq(1)

    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[0].text[0].text[0].value).to eq('Рыба (1.IV.a)')

    expect(bodies[0].text[2].text[3].text[4].text[1].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[1].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[1].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[1].text[0].value.split.join(' ')).to eq('Сомнение, конечно, амбивалентно представляет принцип восприятия. Отношение к современности натурально индуцирует мир, исходя из принятого мнения. Интересно отметить, что любовь, как принято считать, дискредитирует данный структурализм, отрицая очевидное. Надо сказать, что поливалентность, как следует из вышесказанного, фокусирует постмодернизм. Представляется логичным, что интеллект контролирует класс эквивалентности. Смысл жизни ясен не всем. Страсть, в рамках сегодняшних воззрений, очевидна не для всех. Общество заполняет конфликт.'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[4].text[1].text[2]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[2].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[2].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[2].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[2].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[2].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[1].text[2].text[0].value.split.join(' ')).to eq('Объект деятельности, как следует из вышесказанного, рефлектирует себя через структурализм. Интересно отметить, что класс эквивалентности, как принято считать, фокусирует смысл жизни, изменяя привычную реальность. Общество непредсказуемо. Частное рассматривается через закон внешнего мира. Согласно предыдущему, преамбула, конечно, преобразует паллиативный конфликт, исходя из принятого мнения. Конвергенция профанирует постмодернизм. Современная ситуация представляет структурализм.'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[4].text[2]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].text[4].text[2].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[2].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[2].text.size).to eq(2)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[0].text.size).to eq(1)

    expect(bodies[0].text[2].text[3].text[4].text[2].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[0].text[0].text[0].value).to eq('Рыба (1.IV.б)')

    expect(bodies[0].text[2].text[3].text[4].text[2].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[1].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[1].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[2].text[1].text[0].value.split.join(' ')).to eq('Реальность творит объект деятельности. Представляется логичным, что принцип восприятия дискредитирует типичный закон внешнего мира. Жизнь подчеркивает класс эквивалентности. Отсюда естественно следует, что напряжение транспонирует примитивный мир, условно. Ощущение мира непредвзято - это смысл жизни. Поливалентность философски принимает во внимание интеллект.'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[4].text[3]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].text[4].text[3].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[3].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[3].text.size).to eq(2)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[0].text.size).to eq(1)

    expect(bodies[0].text[2].text[3].text[4].text[3].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[0].text[0].text[0].value.split.join(' ')).to eq('Рыба (1.IV.в)'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[4].text[3].text[1]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[1].text.size).to eq(2)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[1].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[1].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[1].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[1].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[1].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[1].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[1].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[1].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[1].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[3].text[1].text[0].text[0].text[0].value.split.join(' ')).to eq('Рыба (1.IV.в.A)'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[4].text[4]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].text[4].text[4].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text.size).to eq(2)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[0].text.size).to eq(1)

    expect(bodies[0].text[2].text[3].text[4].text[4].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[0].text[0].text[0].value.split.join(' ')).to eq('Рыба (1.IV.в)'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[4].text[4].text[1]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text.size).to eq(2)

    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[0].text[0].text[0].value.split.join(' ')).to eq('Рыба (1.IV.в.A)'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text.size).to eq(3)

    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[0].text[0].text[0].value.split.join(' ')).to eq('Рыба (1.IV.в.A.0)'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text.size).to eq(2)

    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[0].text[0].text[0].value.split.join(' ')).to eq('Рыба (1.IV.в.A.0.q)'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[1].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[1].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[1].text[1].text[0].value.split.join(' ')).to eq('Акция вырождена. Объект деятельности натурально подрывает из ряда вон выходящий класс эквивалентности, условно. Принцип восприятия, в рамках сегодняшних воззрений, ясен не всем. Освобождение амбивалентно.'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text.size).to eq(2)

    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[0].text[0].text[0].value.split.join(' ')).to eq('Рыба (1.IV.в.A.0.q)'.split.join(' '))

    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[1].style).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[1].text.size).to eq(1)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[3].text[4].text[4].text[1].text[1].text[2].text[1].text[0].value.split.join(' ')).to eq('Постмодернизм неоднозначен. Напряжение трансформирует конфликт. Созерцание осмысленно профанирует объект деятельности. Смысл жизни категорически раскладывает на элементы паллиативный интеллект. Жизнь принимает во внимание постмодернизм, отрицая очевидное. Свобода ментально порождает и обеспечивает типичный класс эквивалентности. Мир - это субъективный структурализм.'.split.join(' '))

    expect(bodies[0].text[2].text[4]).to be_a(Fb2::Section)
    expect(bodies[0].text[2].text[4].id).to eq(nil)
    expect(bodies[0].text[2].text[4].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text.size).to eq(3)
    expect(bodies[0].text[2].text[4].text[0]).to be_a(Fb2::Title)
    expect(bodies[0].text[2].text[4].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[0].text.size).to eq(1)

    expect(bodies[0].text[2].text[4].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[4].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[4].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[4].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[4].text[0].text[0].text[0].value).to eq('XX')

    expect(bodies[0].text[2].text[4].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[0].text[2].text[4].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[1].style).to eq(nil)
    expect(bodies[0].text[2].text[4].text[1].text.size).to eq(1)
    expect(bodies[0].text[2].text[4].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[4].text[1].text[0].value).to eq('...')

    expect(bodies[0].text[2].text[4].text[2]).to be_a(Fb2::Poem)
    expect(bodies[0].text[2].text[4].text[2].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text.size).to eq(1)

    expect(bodies[0].text[2].text[4].text[2].text[0]).to be_a(Fb2::Stanza)
    expect(bodies[0].text[2].text[4].text[2].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text.size).to eq(10)

    expect(bodies[0].text[2].text[4].text[2].text[0].text[0]).to be_a(Fb2::Verse)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[0].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[0].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[0].style).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[0].text[0].value.split.join(' ')).to eq('В приятну ночь, при лунном свете,'.split.join(' '))

    expect(bodies[0].text[2].text[4].text[2].text[0].text[1]).to be_a(Fb2::Verse)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[1].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[1].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[1].style).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[1].text.size).to eq(1)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[1].text[0].value.split.join(' ')).to eq('Представить счастливо себе,'.split.join(' '))

    expect(bodies[0].text[2].text[4].text[2].text[0].text[2]).to be_a(Fb2::Verse)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[2].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[2].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[2].style).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[2].text.size).to eq(1)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[2].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[2].text[0].value.split.join(' ')).to eq('Что некто есть еще на свете,'.split.join(' '))

    expect(bodies[0].text[2].text[4].text[2].text[0].text[3]).to be_a(Fb2::Verse)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[3].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[3].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[3].style).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[3].text.size).to eq(1)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[3].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[3].text[0].value.split.join(' ')).to eq('Кто думает и о тебе!'.split.join(' '))

    expect(bodies[0].text[2].text[4].text[2].text[0].text[4]).to be_a(Fb2::Verse)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[4].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[4].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[4].style).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[4].text.size).to eq(1)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[4].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[4].text[0].value.split.join(' ')).to eq('Что и она, рукой прекрасной,'.split.join(' '))

    expect(bodies[0].text[2].text[4].text[2].text[0].text[5]).to be_a(Fb2::Verse)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[5].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[5].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[5].style).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[5].text.size).to eq(1)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[5].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[5].text[0].value.split.join(' ')).to eq('По арфе золотой бродя,'.split.join(' '))

    expect(bodies[0].text[2].text[4].text[2].text[0].text[6]).to be_a(Fb2::Verse)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[6].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[6].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[6].style).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[6].text.size).to eq(1)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[6].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[6].text[0].value.split.join(' ')).to eq('Своей гармониею страстной'.split.join(' '))

    expect(bodies[0].text[2].text[4].text[2].text[0].text[7]).to be_a(Fb2::Verse)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[7].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[7].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[7].style).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[7].text.size).to eq(1)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[7].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[7].text[0].value.split.join(' ')).to eq('Зовет к себе, зовет тебя!'.split.join(' '))

    expect(bodies[0].text[2].text[4].text[2].text[0].text[8]).to be_a(Fb2::Verse)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[8].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[8].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[8].style).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[8].text.size).to eq(1)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[8].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[8].text[0].value.split.join(' ')).to eq('Еще день, два, и рай настанет...'.split.join(' '))

    expect(bodies[0].text[2].text[4].text[2].text[0].text[9]).to be_a(Fb2::Verse)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[9].id).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[9].lang).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[9].style).to eq(nil)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[9].text.size).to eq(1)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[9].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[2].text[4].text[2].text[0].text[9].text[0].value.split.join(' ')).to eq('Но ах! твой друг не доживет!'.split.join(' '))

    expect(bodies[0].text[3]).to be_a(Fb2::Section)
    expect(bodies[0].text[3].id).to eq(nil)
    expect(bodies[0].text[3].lang).to eq(nil)
    expect(bodies[0].text[3].text.size).to eq(1)
    expect(bodies[0].text[3].text[0]).to be_a(Fb2::Table)
    expect(bodies[0].text[3].text[0].align).to eq('left')
    expect(bodies[0].text[3].text[0].text.size).to eq(2)

    expect(bodies[0].text[3].text[0].text[0]).to be_a(Fb2::Table::Row)
    expect(bodies[0].text[3].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[3].text[0].text[0].text[0]).to be_a(Fb2::Table::Header)
    expect(bodies[0].text[3].text[0].text[0].text[0].text.size).to eq(1)
    expect(bodies[0].text[3].text[0].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[3].text[0].text[0].text[0].text[0].value).to eq('header')

    expect(bodies[0].text[3].text[0].text[1]).to be_a(Fb2::Table::Row)
    expect(bodies[0].text[3].text[0].text[1].text.size).to eq(1)
    expect(bodies[0].text[3].text[0].text[1].text[0]).to be_a(Fb2::Table::Column)
    expect(bodies[0].text[3].text[0].text[1].text[0].text.size).to eq(1)
    expect(bodies[0].text[3].text[0].text[1].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[0].text[3].text[0].text[1].text[0].text[0].value).to eq('text')

    expect(bodies[1].lang).to eq(nil)
    expect(bodies[1].name).to eq('notes')
    expect(bodies[1].text.size).to eq(7)
    expect(bodies[1].text[0]).to be_a(Fb2::Title)
    expect(bodies[1].text[0].lang).to eq(nil)
    expect(bodies[1].text[0].text.size).to eq(1)

    expect(bodies[1].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[1].text[0].text[0].id).to eq(nil)
    expect(bodies[1].text[0].text[0].lang).to eq(nil)
    expect(bodies[1].text[0].text[0].style).to eq(nil)
    expect(bodies[1].text[0].text[0].text.size).to eq(1)
    expect(bodies[1].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[1].text[0].text[0].text[0].value).to eq('Сноски')

    expect(bodies[1].text[1]).to be_a(Fb2::Section)
    expect(bodies[1].text[1].id).to eq('annotation_src')
    expect(bodies[1].text[1].lang).to eq(nil)
    expect(bodies[1].text[1].text.size).to eq(2)

    expect(bodies[1].text[1].text[0]).to be_a(Fb2::Title)
    expect(bodies[1].text[1].text[0].lang).to eq(nil)
    expect(bodies[1].text[1].text[0].text.size).to eq(1)
    expect(bodies[1].text[1].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[1].text[1].text[0].text[0].id).to eq(nil)
    expect(bodies[1].text[1].text[0].text[0].style).to eq(nil)
    expect(bodies[1].text[1].text[0].text[0].lang).to eq(nil)
    expect(bodies[1].text[1].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[1].text[1].text[0].text[0].text[0].value).to eq('Источник аннотации:')

    expect(bodies[1].text[1].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[1].text[1].text[1].id).to eq(nil)
    expect(bodies[1].text[1].text[1].style).to eq(nil)
    expect(bodies[1].text[1].text[1].lang).to eq(nil)
    expect(bodies[1].text[1].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[1].text[1].text[1].text[0].value).to eq('Какое-то школьное сочинение')

    expect(bodies[1].text[2]).to be_a(Fb2::Section)
    expect(bodies[1].text[2].id).to eq('note_1')
    expect(bodies[1].text[2].lang).to eq(nil)
    expect(bodies[1].text[2].text.size).to eq(2)

    expect(bodies[1].text[2].text[0]).to be_a(Fb2::Title)
    expect(bodies[1].text[2].text[0].lang).to eq(nil)
    expect(bodies[1].text[2].text[0].text.size).to eq(1)
    expect(bodies[1].text[2].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[1].text[2].text[0].text[0].id).to eq(nil)
    expect(bodies[1].text[2].text[0].text[0].style).to eq(nil)
    expect(bodies[1].text[2].text[0].text[0].lang).to eq(nil)
    expect(bodies[1].text[2].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[1].text[2].text[0].text[0].text[0].value).to eq('1')

    expect(bodies[1].text[2].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[1].text[2].text[1].id).to eq(nil)
    expect(bodies[1].text[2].text[1].style).to eq(nil)
    expect(bodies[1].text[2].text[1].lang).to eq(nil)
    expect(bodies[1].text[2].text[1].text.size).to eq(1)
    expect(bodies[1].text[2].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[1].text[2].text[1].text[0].value.split.join(' ')).to eq('Ну, что, князь, Генуа и Лукка стали не больше, как поместьями фамилии Бонапарте. Нет, я вас предупреждаю, если вы мне не скажете, что у нас война, если вы еще позволите себе защищать все гадости, все ужасы этого Антихриста (право, я верю, что он Антихрист)- я вас больше не знаю, вы уж не друг мой, вы уж не мой верный раб, как вы говорите.'.split.join(' '))

    expect(bodies[1].text[3]).to be_a(Fb2::Section)
    expect(bodies[1].text[3].id).to eq('note_2')
    expect(bodies[1].text[3].lang).to eq(nil)
    expect(bodies[1].text[3].text.size).to eq(2)

    expect(bodies[1].text[3].text[0]).to be_a(Fb2::Title)
    expect(bodies[1].text[3].text[0].lang).to eq(nil)
    expect(bodies[1].text[3].text[0].text.size).to eq(1)
    expect(bodies[1].text[3].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[1].text[3].text[0].text[0].id).to eq(nil)
    expect(bodies[1].text[3].text[0].text[0].style).to eq(nil)
    expect(bodies[1].text[3].text[0].text[0].lang).to eq(nil)
    expect(bodies[1].text[3].text[0].text[0].text.size).to eq(1)
    expect(bodies[1].text[3].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[1].text[3].text[0].text[0].text[0].value).to eq('2')

    expect(bodies[1].text[3].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[1].text[3].text[1].lang).to eq(nil)
    expect(bodies[1].text[3].text[1].text.size).to eq(1)
    expect(bodies[1].text[3].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[1].text[3].text[1].text[0].value.split.join(' ')).to eq('Я вижу, что я вас пугаю,'.split.join(' '))

    expect(bodies[1].text[4]).to be_a(Fb2::Section)
    expect(bodies[1].text[4].id).to eq('note_3')
    expect(bodies[1].text[4].lang).to eq(nil)
    expect(bodies[1].text[4].text.size).to eq(2)

    expect(bodies[1].text[4].text[0]).to be_a(Fb2::Title)
    expect(bodies[1].text[4].text[0].lang).to eq(nil)
    expect(bodies[1].text[4].text[0].text.size).to eq(1)
    expect(bodies[1].text[4].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[1].text[4].text[0].text[0].id).to eq(nil)
    expect(bodies[1].text[4].text[0].text[0].style).to eq(nil)
    expect(bodies[1].text[4].text[0].text[0].lang).to eq(nil)
    expect(bodies[1].text[4].text[0].text[0].text.size).to eq(1)
    expect(bodies[1].text[4].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[1].text[4].text[0].text[0].text[0].value).to eq('3')

    expect(bodies[1].text[4].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[1].text[4].text[1].id).to eq(nil)
    expect(bodies[1].text[4].text[1].style).to eq(nil)
    expect(bodies[1].text[4].text[1].lang).to eq(nil)
    expect(bodies[1].text[4].text[1].text.size).to eq(1)
    expect(bodies[1].text[4].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[1].text[4].text[1].text[0].value.split.join(' ')).to eq('Если y вас, граф (или князь), нет в виду ничего лучшего и если перспектива вечера у бедной больной не слишком вас пугает, то я буду очень рада видеть вас нынче у себя между семью и десятью часами. Анна Шерер.'.split.join(' '))

    expect(bodies[1].text[5]).to be_a(Fb2::Section)
    expect(bodies[1].text[5].id).to eq('note_4')
    expect(bodies[1].text[5].lang).to eq(nil)
    expect(bodies[1].text[5].text.size).to eq(2)

    expect(bodies[1].text[5].text[0]).to be_a(Fb2::Title)
    expect(bodies[1].text[5].text[0].lang).to eq(nil)
    expect(bodies[1].text[5].text[0].text.size).to eq(1)
    expect(bodies[1].text[5].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[1].text[5].text[0].text[0].id).to eq(nil)
    expect(bodies[1].text[5].text[0].text[0].style).to eq(nil)
    expect(bodies[1].text[5].text[0].text[0].lang).to eq(nil)
    expect(bodies[1].text[5].text[0].text[0].text.size).to eq(1)
    expect(bodies[1].text[5].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[1].text[5].text[0].text[0].text[0].value).to eq('4')

    expect(bodies[1].text[5].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[1].text[5].text[1].id).to eq(nil)
    expect(bodies[1].text[5].text[1].style).to eq(nil)
    expect(bodies[1].text[5].text[1].lang).to eq(nil)
    expect(bodies[1].text[5].text[1].text.size).to eq(1)
    expect(bodies[1].text[5].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[1].text[5].text[1].text[0].value.split.join(' ')).to eq('О! какое жестокое нападение!'.split.join(' '))

    expect(bodies[1].text[6]).to be_a(Fb2::Section)
    expect(bodies[1].text[6].id).to eq('note_5')
    expect(bodies[1].text[6].lang).to eq(nil)
    expect(bodies[1].text[6].text.size).to eq(2)

    expect(bodies[1].text[6].text[0]).to be_a(Fb2::Title)
    expect(bodies[1].text[6].text[0].lang).to eq(nil)
    expect(bodies[1].text[6].text[0].text.size).to eq(1)
    expect(bodies[1].text[6].text[0].text[0]).to be_a(Fb2::Paragraph)
    expect(bodies[1].text[6].text[0].text[0].id).to eq(nil)
    expect(bodies[1].text[6].text[0].text[0].style).to eq(nil)
    expect(bodies[1].text[6].text[0].text[0].lang).to eq(nil)
    expect(bodies[1].text[6].text[0].text[0].text.size).to eq(1)
    expect(bodies[1].text[6].text[0].text[0].text[0]).to be_a(Fb2::Text)
    expect(bodies[1].text[6].text[0].text[0].text[0].value).to eq('5')

    expect(bodies[1].text[6].text[1]).to be_a(Fb2::Paragraph)
    expect(bodies[1].text[6].text[1].id).to eq(nil)
    expect(bodies[1].text[6].text[1].style).to eq(nil)
    expect(bodies[1].text[6].text[1].lang).to eq(nil)
    expect(bodies[1].text[6].text[1].text.size).to eq(1)
    expect(bodies[1].text[6].text[1].text[0]).to be_a(Fb2::Text)
    expect(bodies[1].text[6].text[1].text[0].value.split.join(' ')).to eq('Прежде всего скажите, как ваше здоровье?'.split.join(' '))
  end
end
