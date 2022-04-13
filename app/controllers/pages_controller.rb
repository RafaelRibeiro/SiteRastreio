class PagesController < ApplicationController
  
  def index
  end

  def tracking
  
    @tracking = Tracking.new(tracking_code: params[:tracking_code])
    
    if @tracking.save
      set_histories(@tracking)
      flash[:alert] = "Rastreio Salvo"
    else
      @tracking = Tracking.find_by(tracking_code: params[:tracking_code])
      @tracking.histories.destroy_all
      set_histories(@tracking)
    end

    @trackings = Tracking.all
  end
    
  private

  def set_histories(tracking)
    agent = Mechanize.new
    page = agent.get "https://proxyapp.correios.com.br/v1/sro-rastro/#{tracking.tracking_code}"
    
    response = JSON.parse(page.body) #Analisar o JSON
    
    if response["objetos"].first["eventos"]
      response["objetos"].first["eventos"].each do |evento|
        History.create(description: evento["descricao"], icon: evento["urlIcone"], tracking: tracking,data: evento["dtHrCriado"])
      end
    
      flash[:alert] = "Rastreio já cadastrado no BD"
    else
      tracking.destroy
      flash[:alert]="Codigo de Rastreio Invalido"
      render :index
    end
  end 
end
