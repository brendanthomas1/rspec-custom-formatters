require 'rspec/core/formatters/console_codes'

class FullDescriptionFormatter
  OVERRIDDEN_METHODS = %i[example_passed example_failed example_pending]

  RSpec::Core::Formatters.register self, *OVERRIDDEN_METHODS 

  def initialize(output)
    @output = output
  end

  def example_failed(notification)
    @output << make_pretty(full_description(notification), :failure)
  end

  def example_passed(notification)
    @output << make_pretty(full_description(notification), :success)
  end

  def example_pending(notification)
    @output << make_pretty(full_description(notification), :pending)
  end

  private

  def full_description(notification)
    notification.example.metadata[:full_description] << "\n\n"
  end

  def make_pretty(text, status)
    return unless status.in? %i[success failure pending]
    RSpec::Core::Formatters::ConsoleCodes.wrap(text, status)
  end
end
