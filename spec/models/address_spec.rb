require 'spec_helper'

describe Address do
  it { should belong_to :user }
  it { should belong_to :country }
  it { should have_many :orders }

  describe "Model setup and utilities" do
    let(:address) { Address.make! }
    let(:user)    { address.user }

    describe "set_default" do
      it "should set default" do
        address.set_default
        address.default.should be_true
      end

      it "should set default" do
        @address = user.addresses.make!( default: true )
        @address.default.should be_true
        address.reload
        address.default.should_not be_true
      end
    end
    
    describe "description" do
      it "should to_s equal country name" do
        address.to_s.should equal address.country.name
      end
    end
  end
end