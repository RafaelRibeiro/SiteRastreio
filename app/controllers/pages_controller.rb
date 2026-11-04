class PagesController < ApplicationController
  
  def index
  end

  def tracking
  
    @tracking = Tracking.new(tracking_code: params[:tracking_code])
    
    if @tracking.save
      set_histories(@tracking)
      flash[:alert] = "Rastreio Salvo"
    else
      @tracking = Tracking.find_by!(tracking_code: params[:tracking_code])
      @tracking.histories.destroy_all
      set_histories(@tracking)
    end

    @trackings = Tracking.all
  end
    
  private

  def set_histories(tracking)
    agent = Mechanize.new

    begin
      page = agent.get "https://proxyapp.correios.com.br/v1/sro-rastro/#{tracking.tracking_code}"
    rescue Mechanize::Error, Net::OpenTimeout, Net::ReadTimeout => e
      Rails.logger.error("Erro ao consultar Correios: #{e.message}")
    
      flash[:alert] = "Não foi possível consultar os Correios. Tente novamente."
      render :index
      return
    end
    
    # Analisar o JSON
    begin
      response = JSON.parse(page.body)
    rescue JSON::ParserError => e
      Rails.logger.error("Erro ao interpretar resposta dos Correios: #{e.message}")
    
      flash[:alert] = "Não foi possível interpretar a resposta dos Correios."
      render :index
      return
    end

    if response["objetos"].present? && response["objetos"].first["eventos"].present?
      tracking.histories.destroy_all # Exclusão só acontece depois que confirmamos que existem eventos na resposta
      
      response["objetos"].first["eventos"].each do |evento|
        History.create(
          description: evento["descricao"], 
          icon: evento["urlIcone"], 
          tracking: tracking,
          data: evento["dtHrCriado"]
        )
      end
    
      flash[:alert] = "Rastreio já cadastrado no BD"
    else
      tracking.destroy
      flash[:alert]="Codigo de Rastreio Invalido"
      render :index
    end
  end 
end
