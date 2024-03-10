class RedirectsController < ApplicationController
    # layout 'redirect', only: [:read]
  
    def read
      @card = Card.find_by(unique_key: params[:id])
      if @card.nil?
        flash.now[:alert] = 'Karta sa nenašla !'
      elsif @card.destination_url.blank?
        flash.now[:alert] = 'URL adresa presmerovania je prázdna !'
        @card = nil # Ensuring @card is not used in the view
      else
        # If @card is present and destination_url is not blank, increment redirect_counter
        unless @card.destination_url == 'https://ikarty.eu/pages/zaciname'
          @card.increment!(:redirect_counter)
        end
      end
      # No explicit rendering; it will automatically render read.html.erb
    end
  end
  