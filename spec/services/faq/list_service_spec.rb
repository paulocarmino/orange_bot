require_relative './../../spec_helper.rb'

describe FaqModule::ListService do
  before do
    @company = create(:company)
  end

  describe '#call' do

    # Command list
    it "with list command: With zero faqs, return don't find message" do
      @listService = FaqModule::ListService.new({}, 'list')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with two faqs, find questions and answer in response" do
      @listService = FaqModule::ListService.new({}, 'list')

      faq1 = create(:faq, company: @company)
      faq2 = create(:faq, company: @company)

      response = @listService.call()

      expect(response).to match(faq1.question)
      expect(response).to match(faq1.answer)

      expect(response).to match(faq2.question)
      expect(response).to match(faq2.answer)
    end

    # Command search
    it "with search command: With empty query, return don't find message" do
      @listService = FaqModule::ListService.new({}, 'search')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with search command: With valid query, find question and answer in response" do
      faq = create(:faq, company: @company)

      @listService = FaqModule::ListService.new({'query' => faq.question.split(" ").sample}, 'list')

      response = @listService.call()

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end

    # Command search_by_hashtag
    it "with search_by_hashtag command: With invalid hashtag, return don't find message" do
      @listService = FaqModule::ListService.new({'query' => ''}, 'search_by_hashtag')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with search_by_hashtag command: with valid hashtags, find question and asnwer in response" do
      faq = create(:faq, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:faq_hashtag, faq: faq, hashtag: hashtag)

      @listService = FaqModule::ListService.new({'query' => hashtag.name}, 'search_by_hashtag')

      response = @listService.call()

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end
  end
end
