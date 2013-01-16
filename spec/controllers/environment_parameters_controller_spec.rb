require File.dirname(__FILE__) + '/../spec_helper'

describe EnvironmentParametersController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => EnvironmentParameter.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    EnvironmentParameter.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    EnvironmentParameter.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(environment_parameter_url(assigns[:environment_parameter]))
  end

  it "edit action should render edit template" do
    get :edit, :id => EnvironmentParameter.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    EnvironmentParameter.any_instance.stubs(:valid?).returns(false)
    put :update, :id => EnvironmentParameter.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    EnvironmentParameter.any_instance.stubs(:valid?).returns(true)
    put :update, :id => EnvironmentParameter.first
    response.should redirect_to(environment_parameter_url(assigns[:environment_parameter]))
  end

  it "destroy action should destroy model and redirect to index action" do
    environment_parameter = EnvironmentParameter.first
    delete :destroy, :id => environment_parameter
    response.should redirect_to(environment_parameters_url)
    EnvironmentParameter.exists?(environment_parameter.id).should be_false
  end
end
