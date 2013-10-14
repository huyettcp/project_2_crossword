require 'spec_helper'

describe WordsController, "GET index" do
  before { get :index }
  it { should respond_with(:success)}
  it { should render_with_layout }

  it { should render_template(:index)}

  #it { should render_template(:partial => '_crossword') }
  #it { should render_template(:partial => '_weaver') }
  it { should render_template(:partial => false) }

end

