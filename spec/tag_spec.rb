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

  it "should fail if a tag with that name already exists" do
    HasTags::Tag.create(name: "Sports")
    HasTags::Tag.create(name: "Sports") 
    expect(HasTags::Tag.all.count).to eq(1)
  end 

  it "should return all top level tags" do
    tag1 = HasTags::Tag.create(name: "Sports")
    tag2 = HasTags::Tag.create(name: "Lax", context_id: tag1.id)
    tag3 = HasTags::Tag.create(name: "Hockey", context_id: tag1.id)
    tag4 = HasTags::Tag.create(name: "Food")

    expect(HasTags::Tag.top_level_tags).not_to include(tag2, tag3)
    expect(HasTags::Tag.top_level_tags).to include(tag1, tag4) 
  end
end
