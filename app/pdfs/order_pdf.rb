class OrderPdf < Prawn::Document
  def initialize(order, view)
    super(page_size: 'A4', page_layout: :portrait)
    @order = order
    @view = view
  end
end