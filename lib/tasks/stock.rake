namespace :stock do
  desc "Update Price column"
  task priceUpdate: :environment do
    Stock.update_price_column
  end

end
