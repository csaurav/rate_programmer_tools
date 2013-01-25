require 'spec_helper'
include RateProgrammerTools

describe ResultModel do
  describe "#new" do
    it "should add error parameter to error collection" do
      result_model = ResultModel.new(error: "Message Test")
      result_model.errors.should include("Message Test")
    end

    it "should add message parameter to message collection" do
      result_model = ResultModel.new(message: "Message Test")
      result_model.messages.should include("Message Test")
    end

    it "should set model parameter as model instance variable" do
      model = Array.new
      result_model = ResultModel.new(model: model)
      result_model.model.should be(model)
    end
  end

  describe "#has_errors" do
    it "should be true if errors collection contains errors" do
      result_model = ResultModel.new(error: "error message")
      result_model.has_errors.should eq(true)
    end
  end

  describe "#add_error" do
    it "should add error to error collection" do
      result_model = ResultModel.new
      result_model.add_error "error message"
      result_model.errors.should include("error message")
    end
  end

  describe "#add_message" do
    it "should add message to message collection" do
      result_model = ResultModel.new
      result_model.add_message "message"
      result_model.messages.should include("message")
    end
  end
end