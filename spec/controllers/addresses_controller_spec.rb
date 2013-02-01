require 'spec_helper'

describe AddressesController do
  let!(:user)             { User.make!}
  let!(:address)          { user.addresses.make! }
  let(:address_attr)      {
                            {
                              street_address: 'street-1',
                              city: 'city-1',
                              state: 'state-1',
                              zip: 12223,
                              country_id: 1,
                              phone: 2312,
                              user_id: user.id
                            }
                          }
  let(:address_attr_fail) {
                            { 
                              street_address: 'street-1',
                              city: 'city-1',
                              state: 'state-1',
                              zip: 12223,
                              country_id: 1,
                              user_id: user.id
                            }
                          }

  before { sign_in user }

  describe "GET 'new'" do
    it "return http success" do
      get :new, format: :js
      response.should be_success
    end

    it "assigns to the new address" do
      get :new, format: :js
      assigns(:address).should_not be_nil
    end
  end

  describe "POST 'create'" do
    it "return http success" do
      post :create, address: address_attr, format: :js
      response.should be_success
    end

    it "creates a new address" do
      expect{
        post :create, address: address_attr, format: :js
      }.to change(Address, :count).by(1)
    end

     it "should render json error" do
      post :create, address: address_attr_fail, format: :js
      response.body.should include "can't be blank"
    end
  end

  describe "Get 'edit'" do
    it "return http success" do
      get :edit, id: address.id, format: :js
      response.should be_success
    end

    it "hould assign the address not nil" do
      get :edit, id: address.id, format: :js
      assigns[:address].should_not be_nil
    end

    it "hould assign the address to the view" do
      get :edit, id: address.id, format: :js
      assigns[:address].should eq address
    end
  end

  describe "PUT 'update'" do
    before :all do
      @address = user.addresses.make!
    end

    it "return http success" do
      put :update, id: @address.id, address: address_attr, format: :js
      response.should be_success
    end

    it "should located the requested @address " do
      put :update, id: @address.id, address: address_attr, format: :js
      @address.reload
      assigns(:address).should eq(@address) 
    end

    it "should render json error" do
      put :update, id: @address.id, address: address_attr, format: :js
      @address.reload
      @address.street_address.should eq("street-1")
    end
  end

  describe 'DELETE destroy' do
    it "return http success" do
      delete :destroy, id: address.id, format: :js
      response.should be_success
    end

    it "should deletes the address" do
      expect{
        delete :destroy, id: address.id, format: :js
      }.to change(Address,:count).by(-1)
    end
  end

end