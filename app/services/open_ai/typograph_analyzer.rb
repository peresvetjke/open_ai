class OpenAi::TypographAnalyzer
  # @return [String]
  def instruction
    <<~HEREDOC
      Я занимаюсь анализом типографа. И хочу, чтобы ты помог оценить, какие конкретно изменения он вносит в текст.
      Я пришлю тебе примеры исходного текста ("Source") и обработанного текста ("Result").

      Твое задание: описать в пункт, что делает данный типограф, приводя примеры с цитатами из "Source" и "Result" для каждого из пунктов.

      Пример ответа:
      - заменяет обычные пробелов на неразрывные ("### Трамп — крупный девелопер" -> "<p>### Трамп&nbsp;&mdash; крупный девелопер</p>")
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
end
