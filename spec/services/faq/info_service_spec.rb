require_relative './../../spec_helper.rb'

describe FaqModule::InfoService do
  before do
    @company = create(:company)
  end

  describe '#call' do
    it "Teste" do
      faq = create(:faq, company: @company)
      @infoService = FaqModule::InfoService.new({"id" => faq.id})
      response = @infoService.call()

      expect(response).to match(response)
    end
  end
end
