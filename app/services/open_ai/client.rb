class OpenAi::Client
  REQUEST_TIMEOUT = 240

  # @param [Array<String>]
  def initialize(messages, request_timeout = REQUEST_TIMEOUT)
    @messages = messages
    @client = OpenAI::Client.new(
      access_token: Rails.application.credentials.open_ai.api_key,
      uri_base: 'https://oai.hconeai.com/',
      request_timeout: request_timeout
    )
  end

  # @param [Hash]
  # @return [Hash]
  def call(opts)
    @client.chat(
      parameters: {
        model: opts[:model],
        temperature: opts[:temperature],
        messages: @messages.map { |m| { role: opts[:role], content: m } }
      }
    )
  end
end
