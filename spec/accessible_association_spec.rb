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
    end

    describe "when assoc is not set" do
      describe ".assoc=" do
        it "should build the associated object" do
          params = { :name => 'namezz', :status => 'complete' }
          @instance.should_receive(:build_assoc).with(params)
          @instance.assoc = params
        end

        it "should not call the original method when passed a hash" do
          params = { :name => 'namezz', :status => 'complete' }
          @instance.stub!(:build_assoc)
          @instance.assoc = params
          @instance.assoc.should be_nil
        end

        it "should call the original method if a hash is not passed" do
          params = 'new'
          @instance.assoc = params
          @instance.assoc.should == params
        end
      end
    end

    describe "when assoc is set" do
      before(:each) do
        @instance.assoc = 'original'
      end

      describe ".assoc=" do
        it "should update the associated object" do
          params = { :name => 'namezz', :status => 'complete' }
          @instance.assoc.should_receive(:update_attributes).with(params)
          @instance.assoc = params
        end

        it "should not call the original method when passed a hash" do
          params = { :name => 'namezz', :status => 'complete' }
          @instance.assoc.stub!(:update_attributes)
          @instance.assoc = params
          @instance.assoc.should == 'original'
        end

        it "should call the original method if a hash is not passed" do
          params = 'new'
          @instance.assoc = params
          @instance.assoc.should == params
        end
      end
    end
  end

  describe ".accessible_association with multiple params" do
    before(:each) do
      klass = Class.new(AccessibleAssociationBase) do
        attr_accessor :assoc_one, :assoc_two
        accessible_association :assoc_one, :assoc_two
      end
      @instance = klass.new
    end
    describe "when associations are not set" do
      describe "assoc_one=" do
        it "should build the associated object" do
          params = { :name => 'namezz', :status => 'complete' }
          @instance.should_receive(:build_assoc_one).with(params)
          @instance.assoc_one = params
        end

        it "should not call the original method when passed a hash" do
          params = { :name => 'namezz', :status => 'complete' }
          @instance.stub!(:build_assoc_one)
          @instance.assoc_one = params
          @instance.assoc_one.should be_nil
        end

        it "should call the original method if a hash is not passed" do
          params = 'new'
          @instance.assoc_one = params
          @instance.assoc_one.should == params
        end
      end

      describe ".assoc_two=" do
        it "should build the associated object" do
          params = { :name => 'namezz', :status => 'complete' }
          @instance.should_receive(:build_assoc_two).with(params)
          @instance.assoc_two = params
        end

        it "should not call the original method when passed a hash" do
          params = { :name => 'namezz', :status => 'complete' }
          @instance.stub!(:build_assoc_two)
          @instance.assoc_two = params
          @instance.assoc_two.should be_nil
        end

        it "should call the original method if a hash is not passed" do
          params = 'new'
          @instance.assoc_two = params
          @instance.assoc_two.should == params
        end
      end
    end

    describe "when associations are set" do
      before do
        @instance.assoc_one = 'assoc one'
        @instance.assoc_two = 'assoc two'
      end
      describe ".assoc_one=" do
        it "should update the associated object" do
          params = { :name => 'namezz', :status => 'complete' }
          @instance.assoc_one.should_receive(:update_attributes).with(params)
          @instance.assoc_one = params
        end

        it "should not call the original method when passed a hash" do
          params = { :name => 'namezz', :status => 'complete' }
          @instance.assoc_one.stub!(:update_attributes)
          @instance.assoc_one = params
          @instance.assoc_one.should == 'assoc one'
        end

        it "should call the original method if a hash is not passed" do
          params = 'new'
          @instance.assoc_one = params
          @instance.assoc_one.should == params
        end
      end

      describe ".assoc_two=" do
        it "should update the associated object" do
          params = { :name => 'namezz', :status => 'complete' }
          @instance.assoc_two.should_receive(:update_attributes).with(params)
          @instance.assoc_two = params
        end

        it "should not call the original method when passed a hash" do
          params = { :name => 'namezz', :status => 'complete' }
          @instance.assoc_two.stub!(:update_attributes)
          @instance.assoc_two = params
          @instance.assoc_two.should == 'assoc two'
        end

        it "should call the original method if a hash is not passed" do
          params = 'new'
          @instance.assoc_two = params
          @instance.assoc_two.should == params
        end
      end
    end
  end
end
