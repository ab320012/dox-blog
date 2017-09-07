require 'rails_helper'

describe 'article search', :type => :feature, js: true do

  context 'ArticleRelevance' do
    it 'sorts articles that contains same word twice will have higher relevancy than once' do
      @articles= [
        Article.new(title: 'test', body: 'test'),
        Article.new(title: 'test', body: 'test test')
      ]
      expect(ArticleRelevance.new('test', @articles[1]).score > ArticleRelevance.new('test', @articles[0]).score).to be true
    end
    it 'sorts articles with title match more than articles with body match' do
      @articles= [
        Article.new(title: 'match', body: 'test'),
        Article.new(title: 'test', body: 'match')
      ]
      expect(ArticleRelevance.new('match', @articles[0]).score > ArticleRelevance.new('match', @articles[1]).score).to be true
    end
  end
  context 'Articles::OrderByTermRelevance' do
    it 'sorts articles in proper order' do
      create(:article, title: 'a', body: 'b')
      create(:article, title: 'aa', body: 'bb')
      expect(Articles::OrderByTermRelevance.new('a', Article.all).call).to eq([
          Article.find_by(title: 'aa'),
          Article.find_by(title: 'a'),
      ])
    end
  end
end
