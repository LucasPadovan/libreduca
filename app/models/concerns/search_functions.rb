module SearchFunctions
  extend ActiveSupport::Concern

  # If you include this module in your model, remember to define a search_cop scope named magic_search.
  # I.E:
  #   search_scope :magic_search do
  #     attributes :name
  #   end

  module ClassMethods
    def filtered_list(query)
      query.present? ? filtered_search(query) : all
    end

    def filtered_search(query)
      # TODO: this will perform horrible and doesn't support dates as before.
      translated_query = query.
          gsub(" #{I18n.t('filtered_search.or').first} ", ' OR ').
          gsub(" #{I18n.t('filtered_search.and').first} ", ' AND ')

      magic_search(translated_query)
    end
  end
end
