class Articles::OrderByTermRelevance
  def initialize(term, articles)
    @articles = articles.search(term)
    @term = term
  end
  def call
    @articles.sort { |article| ArticleRelevance.new(@term, article).score }
  end
end
