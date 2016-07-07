class Doc::Creating < Doc
  include Gerund

  after_create :add_default_lists

  private

  def add_default_lists
    lists.create(title: 'Impact', max_in_words: 'High', min_in_words: 'Low')
    lists.create(title: 'Implementation', max_in_words: 'Easy', min_in_words: 'Hard')
  end
end
