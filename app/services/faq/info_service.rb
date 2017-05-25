module FaqModule
  class InfoService
    def initialize(params)
      @company = Company.last
      @params = params
      @id = params["id"]
    end

    def call
      begin
        faq = @company.faqs.find(@id)
      rescue
        return "Questão inválida, verifique o id"
      end

      info_draw = {
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
          },
          {
            "title": "Opções",
            "actions": [
                  {
                      "name": "press",
                      "text": "Editar questão",
                      "type": "button",
                      "value": "pressed"
                  },
            {
                      "name": "press",
                      "text": "Deletar Questão",
                      "type": "button",
              "style": "danger",
                      "value": "pressed"
                  }
              ]
          }]
      }

      JSON.pretty_generate(info_draw)

    end
  end
end
