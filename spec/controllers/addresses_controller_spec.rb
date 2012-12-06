require 'spec_helper'

describe AddressesController do

  let!(:user)        { User.make!}
  let!(:address)     { user.addresses.make! }

  describe "GET 'show'" do
    it "return http success" do
      get :show, id: address.id
      response.should be_success
    end

    it "assigns the requested address to @address" do
      get :show, id: address.id
      assigns(:address).should eq(address)
    end
      
    it "renders the #show view" do
      get :show, id: address.id
      response.should render_template :show
    end

    it "should assign the all address to the view" do
      get :show, id: address.id
      assigns[:address].should_not be_nil
    end
  end

  describe "GET 'new'" do
    it "assigns to the new address" do
      get :new
      assigns(:address).should_not be_nil
    end
  end

  describe "POST 'create'" do
    let(:address_attr) { { street_address: 'street-1', city: 'city-1', 
                           state: 'state-1', zip: 12223, 
                           country: "Thailand", phone: 2312, email: "test@test.com",
                           user_id: user.id } }


    it "creates a new address" do
      expect{
        post :create, address: address_attr
      }.to change(Address, :count).by(1)
    end

    it "should redirects back to the edit user registration page" do
      post :create, address: address_attr
      response.should redirect_to edit_user_registration_path
    end
  end

  describe "PUT 'update'" do

    let(:address_attr) { { street_address: 'street-1', city: 'city-1', 
                           state: 'state-1', zip: 12223, 
                           country: "Thailand", phone: 2312, email: "test@test.com",
                           user_id: user.id } }
    before :all do
      @address = user.addresses.make!
    end

    it "should located the requested @address " do
      put :update, id: @address.id, address: address_attr
      @address.reload
      assigns(:address).should eq(@address) 
    end

    it "should changes @address's attributes" do
      put :update, id: @address.id, address: address_attr
      @address.reload
      @address.street_address.should eq("street-1")
    end
  end

  describe 'DELETE destroy' do
  
    it "should deletes the address" do
      expect{
        delete :destroy, id: address.id
      }.to change(Address,:count).by(-1)
    end
      
    it "should redirects to edit user's registration path" do
      delete :destroy, id: address.id
      response.should redirect_to edit_user_registration_path
    end
  end

end