class Doc::Creating < Doc
  include Gerund

  before_validation :build_default_lists, on: :create

  private

  def build_default_lists
    build_impact_list(title: 'Impact', max_in_words: 'High', min_in_words: 'Low')
    build_implementation_list(title: 'Implementation', max_in_words: 'Easy', min_in_words: 'Hard')
  end
end
