# encoding: utf-8

class OrderPdf < Prawn::Document
  def initialize(order, view)
    super(page_size: 'A4', page_layout: :portrait)
    @order = order
    @view = view
    header
    bounding_box([bounds.left, bounds.top - 100], height: 650, width: 523) do
      items
      total
    end
    footer
  end

  def price(num)
    self.font("/Library/Fonts/Arial Unicode.ttf") # adjust font path / symbol such as ฿
    @view.number_to_price(num)
  end

  def header
    repeat :all do
      bounding_box([bounds.left, bounds.top], width: 250) do
        text "Shopper", size: 20
        move_down 10
        text "Artellectual Co., Ltd., 5/37 Sukhumvit 71 
              Prakanong Nuea, Wattana, Bangkok
              Thailand, 10110", size: 10
      end

      bounding_box([bounds.left + 260, bounds.top], width: 260) do
        text "Invoice No. ##{@order.id}", style: :bold
        move_down 10
        text "Shipping & Billing to:", style: :bold
        text "#{@order.address.full_address}", size: 10
      end
    end
  end

  def items
    move_down 15
    table items_rows do |t|
      t.cell_style = { borders: [], size: 10 }
      t.column_widths = { 0 => 253, 1 => 90, 2 => 90, 3 => 90 }
      t.row_colors = ["EEEEEE", "FFFFFF"]
      t.header = true
      t.columns(1..3).align = :right

      t.before_rendering_page do |p|
        p.columns(0..3).borders = [:left, :right]
        p.row(0).borders = [:top, :bottom, :left, :right]
        p.row(-1).borders = [:bottom, :left, :right]
      end
    end
  end

  def items_rows
    [["Product name", "Unit Price", "Quantity", "Full Price"]] +
    @order.items.map do |item|
      [
        item.product.name, 
        price(item.product.price), 
        item.quantity, 
        price(item.sub_total)
      ]
    end
  end

  def total
    move_down 15
    table total_rows do
      self.cell_style = { borders: [], size: 10, align: :right }
      self.column_widths = { 0 => 343, 1 => 90, 2 => 90 }
      self.header = true
      rows(2).borders = [:top, :bottom]
    end
  end

  def total_rows
    [
      ["", "Sub Total", "#{price(@order.total)}"],
      ["", "Shipping Rate", "#{price(@order.address.rate) rescue 'not calculated'}"],
      ["", "Balance", "#{price(@order.balance)}"]
    ]
  end

  def footer
    page_count.times do |i|
      page = i + 1
      go_to_page(page)
      bounding_box([bounds.right - 22, bounds.bottom + 10], :width => 50) do
        text "#{page} / #{page_count}", :size => 8
      end
    end
  end
end