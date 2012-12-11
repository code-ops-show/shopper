require 'spec_helper'

describe User do
  it { should have_many :addresses}
  it { should have_many(:orders).through(:addresses) }

  describe "Model setup and utilities" do
    let(:address)     { Address.make! }
    let(:user)        { address.user }

    it "should update with password" do
      user.update_with_password.should be_true
    end

    it "should to_s equal email" do
      user.to_s.should equal user.email
    end

    it "should return default address" do
      user.default_address.should eq address
    end
  end
end
