class Note
  include Mongoid::Document
  include Mongoid::FullTextSearch
  field :title, type: String
  field :content, type: String
  fulltext_search_in :title
end
