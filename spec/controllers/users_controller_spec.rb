require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    
    it "should be successful" do
      get :new
      response.should be_success
    end
  
  end

  describe "POST 'create'" do
    
    describe 'failure' do
      
      before(:each) do
        @attr = {:email => "", :password => "", :password_confirmation => ""}
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end

    describe 'success' do

      before(:each) do
        @attr = {:email => "user@example.com", :password => "foobar", :password_confirmation => "foobar"}
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it "should have a welcome message" do
        post :create, :user => @attr  
        flash[:success].should =~ /welcome to Dealframe/i
      end
    end
  end
end
