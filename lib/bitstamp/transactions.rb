module Bitstamp
  class UserTransactions < Bitstamp::Collection
    def all(options = {})
      path = options[:currency_pair] ? "/v2/user_transactions/#{options[:currency_pair]}" : "/v2/user_transactions"
      Bitstamp::Helper.parse_objects! Bitstamp::Net::post(path, options).to_str, self.model
    end

    def find(order_id, options = {})
      txs = self.all(options).find{|order| order.order_id.to_i == order_id.to_i}
      if txs.is_a?(Array)
        return txs
      else
        return [txs]
      end
    end

    def create(options = {})
    end

    def update(options={})
    end
  end

  class UserTransaction < Bitstamp::Model
    attr_accessor :datetime, :id, :type, :usd,
                  :btc, :fee, :order_id, :btc_usd,
                  :nonce, :eth_btc, :eur, :eth,
                  :btc_eur, :eth_eur, :eth_usd,
                  :xrp, :xrp_usd, :xrp_eur, :xrp_btc,
                  :ltc, :ltc_usd, :ltc_eur, :ltc_btc, 
                  :bch, :bch_usd, :bch_eur, :bch_btc, 
                  :eur_usd
  end

  # adding in methods to pull the last public trades list
  class Transactions < Bitstamp::Model
    attr_accessor :date, :price, :tid, :amount, :type

    def self.from_api(currency_pair)
      Bitstamp::Helper.parse_objects! Bitstamp::Net::get("/v2/transactions/#{currency_pair}").to_str, self
    end
  end
end
