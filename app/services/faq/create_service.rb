module FaqModule
  class CreateService
    def initialize(params)
      @company = Company.last
      @question = params["question-original"]
      @answer = params["answer-original"]
      @hashtags = params["hashtags-original"]
    end

    def call
      Faq.transaction do
        faq = Faq.create(question: @question, answer: @answer, company: @company)
        return "Hashtag Obrigatória" if @hashtags == nil
        @hashtags.split().each do |hashtag|
          faq.hashtags << Hashtag.create(name: hashtag)
        end
      end
      "Criado com Sucesso"
    end

  end
end
