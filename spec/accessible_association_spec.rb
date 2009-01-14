require File.dirname(__FILE__) + '/spec_helper'

class AccessibleAssociationBase
  extend AccessibleAssociation
end

describe AccessibleAssociation do
  it "should define an accessible association method" do 
    AccessibleAssociation.instance_methods.should include('accessible_association')
  end

  describe ".accessible_association" do
    before(:each) do
      klass = Class.new(AccessibleAssociationBase) do
        attr_accessor :assoc
        accessible_association :assoc
      end
      @instance = klass.new
      @instance.assoc = 'original'
    end

    it "should define setter method for the param passed" do
      @instance.should respond_to(:assoc=)
    end

    describe ".assoc=" do
      it "should build the associated object" do
        params = { :name => 'namezz', :status => 'complete' }
        @instance.should_receive(:build_assoc).with(params)
        @instance.assoc = params
        @instance.assoc.should == 'original'
      end

      it "should not call the original method when passed a hash" do
        params = { :name => 'namezz', :status => 'complete' }
        @instance.stub!(:build_assoc)
        @instance.assoc = params
        @instance.assoc.should == 'original'
      end

      it "should call the original method if a hash is not passed" do
        params = 'new'
        @instance.assoc = params
        @instance.assoc.should == 'new'
      end
    end
  end
end

