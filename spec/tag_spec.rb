require 'spec_helper'

describe HasTags::Tag do
  it "should create tag with valid name" do
    HasTags::Tag.create(name: "Sports")
    expect(HasTags::Tag.all.count).to eq(1)
  end

  it "should fail without a name" do
    HasTags::Tag.create(name: nil) 
    expect(HasTags::Tag.all.count).to eq(0) 
  end
end
