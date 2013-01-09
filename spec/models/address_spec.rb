require 'spec_helper'

describe Address do
  it { should belong_to :user }
  it { should belong_to :country }
  it { should have_many :orders }

  describe "Model setup and utilities" do
    let(:address) { Address.make! }
    let(:user)    { address.user }

    it "should set default" do
      address.set_default.should be_true
    end

    it "should set default" do
      @address = user.addresses.make!( default: true )
      @address.default.should be_true
      address.reload
      address.default.should_not be_true
    end
  end
end