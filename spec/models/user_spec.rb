require 'spec_helper'

describe User do
  it { should have_many :addresses}
  it { should have_many(:orders).through(:addresses) }

  describe "Model setup and utilities" do
    let(:user)   { User.make! }

    it "should to_s equal email" do
      user.to_s.should equal user.email
    end
  end
end
