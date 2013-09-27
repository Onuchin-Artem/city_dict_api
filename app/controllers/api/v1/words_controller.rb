class Api::V1::WordsController < Api::V1::BaseController

  def index    
    scope = VocabularyEntry 
    if params[:city_id].present?      
      scope = scope.includes(:metadata).where( :metadata => { :city_id => params[:city_id] } )
    end
    if params[:type].present?
      scope = scope.where(:metadata => {:type_name => params[:type]})     
    end
    if params[:name].present?
      scope = scope.where(:name => [params[:name], params[:name].mb_chars.capitalize.to_s])    
    end

    @words = scope.page(params[:page])
    @pages_data = { :pages_count => @words.total_pages, :per_page => VocabularyEntry::PAGINATES_COUNT, 
                    :current_page => params[:page] || 1 }
  end


  def all
    @words = VocabularyEntry.all
  end


  def show
    @word = VocabularyEntry.find(params[:id])
  end
end
