class OpenAi::Client
  MODEL = 'gpt-3.5-turbo'.freeze
  REQUEST_TIMEOUT = 240
  ROLE = 'user'.freeze
  TEMPERATURE = 0.7

  attr_reader :messages

  # @param [Array<String>]
  def initialize(messages)
    @messages = messages
    @client = OpenAI::Client.new(
      access_token: Rails.application.credentials.open_ai.api_key,
      uri_base: 'https://oai.hconeai.com/',
      request_timeout: REQUEST_TIMEOUT
    )
  end

  # @return [Hash]
  def call(opts = {model: MODEL, temperature: TEMPERATURE})
    @client.chat(
      parameters: {
        model: opts[:model],
        temperature: opts[:temperature],
        messages: @messages.map { |m| { role: ROLE, content: m } }
      }
    )
  end
end
