module OpenAi
  class TypographAnalyzer < Base
    # @return [String]
    def instruction
      <<~HEREDOC
        Я занимаюсь анализом типографа. И хочу, чтобы ты помог оценить, какие конкретно изменения он вносит в текст.

        Я пришлю тебе исходный текст ("Source") и обработанный текст ("Result").

        Твое задание:
        1) описать в пункт, что делает данный типограф
        2) приведи примеры (цитируя фрагменты исходного и обработанного текста) для каждого из пунктов.

        Поехали!
      HEREDOC
    end

    # @param input [Array<String>]
    # @return [String]
    def format_message(input)
      <<~HEREDOC
        Source:
        #{input.first}

        Result:
        #{input.last}
      HEREDOC
    end

    def default_options
      super.merge(temperature: 0.9)
    end
  end
end
