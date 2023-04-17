module SearchFiltersConcern
  extend ActiveSupport::Concern
  def search results
    sort_order = params[:sort] ? "#{params[:sort][:field]} #{params[:sort][:direction]}" : results.default_sort_order
    page = (params[:page] || 1)
    query = params[:query]
    per_page = (params[:per_page] || 16)
    results = query.present? ? results.search(query) : results
    #PAAVAM: disabling pagination for now
    results = results.order(sort_order)
    {
      results: results,
      page: page,
      per_page: per_page
    }
  end
end