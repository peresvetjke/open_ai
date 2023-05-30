module OpenAi
  class Base
    def initialize
      FileUtils.mkdir_p(File.dirname('tmp/logs/.'))
    end

    # @param list_of_inputs [Array<Object>]
    # @param opts [Hash]
    # @return [Boolean]
    def call(list_of_inputs, opts = {})
      messages = prepare_messages(list_of_inputs)
      get_response(messages, opts)
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

    # @param messages [Array<String>]
    # @param opts [Hash]
    # @return [Hash]
    def get_response(messages, opts)
      request = [instruction] + messages
      options = default_options.merge(opts)
      @result = Client.new(request).call(options)
    end

    # @return [Hash]
    def default_options
      {
        model: 'gpt-3.5-turbo',
        role: 'user',
        temperature: 0.7
      }
    end

    # @return [Boolean]
    def success?
      !@result.key?('error')
    end
  end
end
