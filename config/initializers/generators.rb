Rails.application.configure do
  config.generators do |g|
    g.assets false
    g.helper false
    g.jbuilder false
    g.test_framework nil
    g.integration_tool nil
  end
end
