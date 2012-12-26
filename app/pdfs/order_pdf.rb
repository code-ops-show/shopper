class OrderPdf < Prawn::Document
  def initialize(order, view)
    super
    @order = order
    @view = view
  end
end