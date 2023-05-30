module OpenAi
  class ReportFinalizer < Base
    # @return [String]
    def instruction
      <<~HEREDOC
        Я занимаюсь анализом типографа. И хочу, чтобы ты помог оценить, какие конкретно изменения он вносит в текст. Я пришлю тебе отчеты.

        Твое задание: подготовить суммарный отчет на основе отдельных отчетов.

        Поехали!
      HEREDOC
    end

    def default_options
      super.merge(temperature: 0.9)
    end
  end
end
