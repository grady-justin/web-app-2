class BitcoinsController < ApplicationController

  def index
    # add backend code
    # render bitcoins/index view
    @bitcoin = params["amount"].to_f

  # connect to the Blockchain.com Exchange Rates API
  # DON'T CHANGE THIS CODE
  # ----------------------
    require "net/http"
    require "json"
    url = "https://blockchain.info/ticker"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    bitcoin_data = JSON.parse(response)
  # ----------------------

  # using the API, extract current rate of bitcoin in USD
    @usd_rate = bitcoin_data["USD"]["last"]

  # calculate value in USD of user's bitcoin
    @usd_value = @usd_rate * @bitcoin
  end

end