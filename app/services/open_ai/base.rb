class OpenAi::TypographAnalyzer
  def initialize
    FileUtils.mkdir_p(File.dirname('tmp/logs/.'))
  end

  # @param list_of_inputs [Array<Object>]
  # @return [Boolean]
  def call(list_of_inputs)
    messages = prepare_messages(list_of_inputs)
    request_open_ai(messages)
    success?
  end

  # @return [String]
  def result
    @result['choices'].first['message']['content']
  end

  # @return [String]
  def errors
    @result['error']['message']
  end

  private

  # @return [Boolean]
  def success?
    !@result.key?('error')
  end

  # @messages [Array<String>]
  # @return [Hash]
  def request_open_ai(messages)
    @result = ::OpenAiClient.new([instruction] + messages).call
  end

  def options

  end

  # @return [String]
  def instruction
    raise NotImplemented
  end

  # @param list_of_inputs [Array<Object>]
  # @return [Array<String>]
  def prepare_messages(list_of_inputs)
    list_of_inputs.map { |input| format_message(input) }
  end

  # Adjust in sub-classes
  # @param input [Object]
  # @return [String]
  def format_message(input)
    input
  end
end
