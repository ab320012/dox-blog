class ArticleRelevance
  def initialize(term, article)
    @term, @article = term, article
  end
  def score
    i = 0
    i += @article.title.downcase.count(@term.downcase) * 1.5
    i += @article.body.downcase.count(@term.downcase)
    i
  end
end
