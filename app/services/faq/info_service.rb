module FaqModule
  class InfoService
    def initialize(params)
      @company = Company.last
      @id = params["id"]
    end

    def call
      begin
        faq = @company.faqs.find(@id)
      rescue
        return "Questão inválida, verifique o id"
      end

      info_draw = {
        "slack": {
            "text": "Aqui estão as informações do faq #13",
            "attachments": [
                {
                  "title": "#{faq.question}",
                    "fields": [
                        {
                            "title": "Resposta",
                            "value": "#{faq.answer}"
                        },
                        {
                            "title": "Hashtags",
                            "value": "",
                        }
                    ]
                  }
            ]
        }
      }

      JSON.pretty_generate(info_draw)

    end
  end
end
