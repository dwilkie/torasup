module PstnHelpers
  include Torasup::Test::Helpers

  private

  def yaml_file(filename)
    File.join(File.dirname(__FILE__), "../../spec/support/#{filename}")
  end

  def clear_pstn
    Torasup.configure do |config|
      config.custom_pstn_data_file = nil
    end
  end

  def clear_registered_operators
    Torasup.configure do |config|
      config.registered_operators = {}
    end
  end

  def configure_registered_operators(country_id, *operators)
    Torasup.configure do |config|
      config.register_operators(country_id, *operators)
    end
  end

  def configure_with_custom_data(options = {})
    custom_data_files = ["custom_pstn.yaml"]
    custom_data_files << "custom_pstn_2.yaml" if options[:multiple_files]

    custom_data_files.each do |custom_data_file|
      Torasup.configure do |config|
        config.custom_pstn_data_file = File.join(File.dirname(__FILE__), "../support", "/#{custom_data_file}")
      end
    end
  end
end

RSpec.configure do |config|
  config.include(PstnHelpers)

  config.before do
    clear_pstn
    clear_registered_operators
  end
end
