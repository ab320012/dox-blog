class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  belongs_to :author
  validates :author, :title, :body, presence: true
  scope :search_by_relevance, -> (term) do
    if term.nil?
      self
    else
      search(term).order_by_relevance(
        Articles::OrderByTermRelevance.new(term, self).call.map(&:id)
      )
    end
  end
  scope :published, -> { where(published: true).order("created_at desc") }
  scope :featured, -> { where(published: true).where(featured: true).order("id desc") }
  scope :search, -> (term) {
    where("lower(title) like ? or lower(body) like ?", "%#{term.downcase}%", "%#{term.downcase}%")
  }
  scope :order_by_relevance, -> (ids) {
    if ids.empty?
      none
    else
      order("field(id, #{ids.reverse.join(',')}) desc")
    end
  }
  def author
    super || NullAuthor.new
  end
end
