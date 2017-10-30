FactoryGirl.define do
  factory :static_page do
    slug 'test_page'
    markup_type :markdown

    content do
      markup_type == :markdown ? '# Test Content' : '<h1>Test Content</h1>'
    end
  end
end
