module RateProgrammerTools
  class ResultModel
    def initialize(options = {})
      @errors = Array.new
      @messages = Array.new

      @errors.append options[:error] if options[:error]
      @messages.append options[:message] if options[:message]
      @model = options[:model] if options[:model]
    end

    def has_errors
      @errors.count > 0
    end

    def add_error(message)
      @errors << message
    end

    def errors
     @errors
    end

    def messages
      @messages
    end

    def model
      @model
    end

    def model=(model)
      @model = model
    end

    def add_message(message)
      @messages << message
    end
  end
end