module AddressesHelper
  def options_for_countries(selected = nil)
    countries = Country.includes(:shipping_rate).all.map { |c| [c.name, c.id] }
    options_for_select(countries, selected: selected)
  end
end