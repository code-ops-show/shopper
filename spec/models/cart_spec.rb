require 'spec_helper'

describe Cart do
  it { should have_many :cart_items }
  it { should have_many(:products).through(:cart_items) }
  it { should belong_to :user }
end